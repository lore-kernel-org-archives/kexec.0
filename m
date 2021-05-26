Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Marc Zyngier <maz@kernel.org>
Subject: [PATCH 3/4] kernel/resource: Add walk_excluding_child_res() helper
Date: Wed, 26 May 2021 20:05:30 +0100
Message-Id: <20210526190531.62751-4-maz@kernel.org>
In-Reply-To: <20210526190531.62751-1-maz@kernel.org>
References: <20210526190531.62751-1-maz@kernel.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh SHARMA <bhupesh.sharma@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Moritz Fischer <mdf@kernel.org>, kernel-team@android.com

Once we have obtained a resource of a certain type from
find_next_iomem_res(), it doesn't necessarily mean that the whole
resource is usable, and we have cases where a child resource
denotes an exclusion in the initial resource.

Provide a new walker that deals with this exact case, and calls
a callback on each resource fragment that doesn't have a child.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/ioport.h |  4 +++
 kernel/resource.c      | 80 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 8359c50f9988..526314a42ad2 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -323,6 +323,10 @@ extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
+extern int
+walk_excluding_child_res(struct resource *res, void *arg,
+			 int (*func)(struct resource *, void *));
+
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size);
 struct resource *request_free_mem_region(struct resource *base,
diff --git a/kernel/resource.c b/kernel/resource.c
index 311b8d2c9957..1d9b5f653938 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -318,6 +318,86 @@ int release_resource(struct resource *old)
 
 EXPORT_SYMBOL(release_resource);
 
+/**
+ * walk_excluding_child_res - call a callback function on each fragment of
+ *			      a resource that do not have a child resource
+ *
+ * @res: the root resource containing the initial range
+ * @arg: function argument for the callback @func
+ * @func: callback function that is called for each qualifying resource area
+ *
+ * For a given resource, remove all the child resources and feed the
+ * resulting fragments to kexec_locate_mem_hole_callback().
+ */
+int walk_excluding_child_res(struct resource *res, void *arg,
+			     int (*func)(struct resource *, void *))
+{
+	struct resource *tmp, cursor;
+	int ret = 0;
+
+	cursor = *res;
+
+	/* Use .child for the head of the list, .sibling for the tail */
+	cursor.child = cursor.sibling = NULL;
+
+	read_lock(&resource_lock);
+
+	for (tmp = res->child; tmp; tmp = tmp->sibling) {
+		struct resource *new;
+
+		if (cursor.start < tmp->start) {
+			new = kmalloc(sizeof(*new), GFP_KERNEL);
+			if (!new)
+				goto cleanup;
+
+			*new = (struct resource) {
+				.start	= cursor.start,
+				.end	= tmp->start - 1,
+				.flags	= res->flags,
+				.desc	= res->desc,
+				.parent	= res->parent,
+			};
+
+			if (!cursor.child)
+				cursor.child = new;
+			if (cursor.sibling)
+				cursor.sibling->sibling = new;
+			cursor.sibling = new;
+		}
+
+		/*
+		 * This may result in a resource with a negative size
+		 * at the very end of the loop.
+		 */
+		cursor.start = tmp->end + 1;
+	}
+
+	read_unlock(&resource_lock);
+
+	/*
+	 * At this stage, the list pointed to by cursor.child contains
+	 * every non-reserved blocks, completed by 'cursor' which
+	 * contains the potential last block (may be empty).
+	 */
+	for (tmp = cursor.child; tmp; tmp = tmp->sibling) {
+		ret = func(tmp, arg);
+		if (ret)
+			break;
+	}
+
+	if (!ret && cursor.start <= cursor.end)
+		ret = func(&cursor, tmp);
+
+cleanup:
+	while (cursor.child) {
+		tmp = cursor.child;
+		cursor.child = cursor.child->sibling;
+		kfree(tmp);
+	}
+
+	return ret;
+}
+
 /**
  * find_next_iomem_res - Finds the lowest iomem resource that covers part of
  *			 [@start..@end].
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
