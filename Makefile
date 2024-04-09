
.PHONY: test
test:
	helm lint charts/* --set cht_image_tag=unused_tag_for_chart_ci
