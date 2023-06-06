Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C52BC7EE23
	for <kexec@archiver.kernel.org>; Tue,  6 Jun 2023 03:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CO6/xEF3DzBye0ZCiRZie/bXZCaUrGy9OASP2beFZ0Q=; b=CPdQWuLQUKSr52aqIvCk1VeTtT
	hlbIXp2q53X8OWACIGr3/LZ2rViTe1R4UFVfuBMOIm7vJvYrOrP1iouUzqrQNyGKzNsUoO6EkjhwE
	tXTRYBeU85D/VUiyKC69fiECpxwsnERuUlvsczaYwBJDIA9lFGcW4JwUjZsPPJEtQ3tTLvyW3pXI0
	blpBwZXo39fQCB5dBn+fa2AhUn9KEL9ejNlidt05/nVce0HVZ6y9ICZYcBygEhIC+VOhSGpzPnCXY
	huuWuUYpWcM3woTgEkbw26XUDqXgLC1PI8q+C+levJ0fqqvMm3Ne/shlrDUBT1HQuXjzouJ5+vn5Y
	xDBOGJMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6MwL-00HV0z-33;
	Tue, 06 Jun 2023 03:00:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6MwI-00HV00-39
	for kexec@lists.infradead.org;
	Tue, 06 Jun 2023 03:00:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686020452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tXRilKkCioEVIALYe5Wf2FsTaWzsIF1KlSEfbrx8r0=;
	b=L6z9pDZzUFeF80UDzgiOEvxJkwOqZgTJNcYLP1C+kVYwwzOdcbThlkZssPvv3fuTH/w1wS
	eyqK7wJf3/nvUPW7/9bq0Csm+TCJO8+13gAdw5u/nWwdwqRDHf97wG/sHTT4nAYu3H+96j
	amNY9ZdsJLDQUSipvilp0uWXUFnDVR0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-cWtioJ4kNpSPz3vlbjQkIQ-1; Mon, 05 Jun 2023 23:00:51 -0400
X-MC-Unique: cWtioJ4kNpSPz3vlbjQkIQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75ebb50993fso194722385a.2
        for <kexec@lists.infradead.org>; Mon, 05 Jun 2023 20:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686020451; x=1688612451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tXRilKkCioEVIALYe5Wf2FsTaWzsIF1KlSEfbrx8r0=;
        b=d0WLy/ih9IV1DeMwlnBCuCuQn1MkfMm3SWVQWOTDqzG19A9HxqonEgd8vyZsCiu1T5
         pd+WvMCks7eWeKOF3Uqi1ttXMrPDRMcczfKS06Gv8KV7sEXpFaVYdkJU9o5Prp9puZD6
         dVhSTkRgwSxvaIH2/71dygKyvhxB0d+sFZir/M9GOmBDbMSkIZOQFWqmu2/Il1/bGpm7
         6+TTsAE7ZlXcwe7whR9ti9gLoqGKZ6ZwDdvnLaFMaBv4nXexCGpDg25dh2nlUzipr52e
         jqRI2w78Vfrn63QkfOo+z3CnCcDGNLLEAj8tmuJIjoI3BhoZjTBN47v7oU4sWkm3OWdo
         joTA==
X-Gm-Message-State: AC+VfDxDbFC3mZjkoC39E+PlUocdGQ0wp27ZBFmFr4UIYVOQPxnBKOFv
	AQN9LL3sf+jtNZJDRnt3CSJO3H14vE2iXSabrkzSgIjx18ncowJeoDietYRpwuN5lrJ+i0kCHEP
	DSYxfWzoIduhLUaHEW9rZ
X-Received: by 2002:a05:620a:2794:b0:75b:23a1:3616 with SMTP id g20-20020a05620a279400b0075b23a13616mr687814qkp.39.1686020451101;
        Mon, 05 Jun 2023 20:00:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6x/0Cm40AnwLIqaeE+ggEj23Du26bLV9lLIl1Uco/4+LixRC0yQOluK0EdsDvibDengYz/ww==
X-Received: by 2002:a05:620a:2794:b0:75b:23a1:3616 with SMTP id g20-20020a05620a279400b0075b23a13616mr687774qkp.39.1686020450851;
        Mon, 05 Jun 2023 20:00:50 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a784100b0025069c8a151sm6407398pjl.53.2023.06.05.20.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 20:00:50 -0700 (PDT)
Date: Tue, 6 Jun 2023 10:55:06 +0800
From: Coiby Xu <coxu@redhat.com>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, 
	akpm@linux-foundation.org, ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com, 
	jason.zeng@intel.com, lei.l.li@intel.com, steven.sistare@oracle.com, 
	fam.zheng@bytedance.com, mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: Re: [RFC v3 07/21] mm: PKRAM: introduce super block
Message-ID: <aee5eximmv33ke26xrodm7tlqwwojalf2lz3zrgkt75bxeuupe@y3t2sfgdcy7k>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
 <1682554137-13938-8-git-send-email-anthony.yznaga@oracle.com>
 <upgf3qmqxn7xzbnwwt6nxau4ugqkq7szdaheewzbok27xwch4e@6tdnhkqspok4>
 <f287334c-4054-525e-52ea-a0bbf077b653@oracle.com>
MIME-Version: 1.0
In-Reply-To: <f287334c-4054-525e-52ea-a0bbf077b653@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_200055_111253_67DCFC58 
X-CRM114-Status: GOOD (  26.61  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Jun 05, 2023 at 07:01:56PM -0700, Anthony Yznaga wrote:
>Hi Coiby,
>
>On 6/4/23 7:40 PM, Coiby Xu wrote:
>>Hi Anthony,
>>
>>On Wed, Apr 26, 2023 at 05:08:43PM -0700, Anthony Yznaga wrote:
>>>The PKRAM super block is the starting point for restoring preserved
>>>memory. By providing the super block to the new kernel at boot time,
>>>preserved memory can be reserved and made available to be restored.
>>>To point the kernel to the location of the super block, one passes
>>>its pfn via the 'pkram' boot param.
>>
>>I'm curious to ask how will the 'pkram' boot param be passed. It seems I
>>can't find the answer in this patch set.
>
>The pfn of the super block read from /sys/kernel/pkram is passed to
>
>the next kernel by adding the boot parameter, pkram=3D<super block pfn>.
>
>The next kernel picks it up through the early_param("pkram", =

>parse_pkram_sb_pfn)
>
>in this patch below.

Thanks for the explanation! Sorry I didn't make my question clear. I
should have asked who is going to read /sys/kernel/pkram how this pkram
boot parameter will be added for the next kernel.

>
>
>Anthony
>
>
>>
>>
>>>For that purpose, the pkram super
>>>block pfn is exported via /sys/kernel/pkram. If none is passed, any
>>>preserved memory will not be kept, and a new super block will be
>>>allocated.
>>>
>>>Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
>>>Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>>>---
>>>mm/pkram.c | 102 =

>>>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>>1 file changed, 100 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/mm/pkram.c b/mm/pkram.c
>>>index da166cb6afb7..c66b2ae4d520 100644
>>>--- a/mm/pkram.c
>>>+++ b/mm/pkram.c
>>>@@ -5,15 +5,18 @@
>>>#include <linux/init.h>
>>>#include <linux/io.h>
>>>#include <linux/kernel.h>
>>>+#include <linux/kobject.h>
>>>#include <linux/list.h>
>>>#include <linux/mm.h>
>>>#include <linux/module.h>
>>>#include <linux/mutex.h>
>>>#include <linux/notifier.h>
>>>+#include <linux/pfn.h>
>>>#include <linux/pkram.h>
>>>#include <linux/reboot.h>
>>>#include <linux/sched.h>
>>>#include <linux/string.h>
>>>+#include <linux/sysfs.h>
>>>#include <linux/types.h>
>>>
>>>#include "internal.h"
>>>@@ -82,12 +85,38 @@ struct pkram_node {
>>>#define PKRAM_ACCMODE_MASK=A0=A0=A0 3
>>>
>>>/*
>>>+ * The PKRAM super block contains data needed to restore the =

>>>preserved memory
>>>+ * structure on boot. The pointer to it (pfn) should be passed =

>>>via the 'pkram'
>>>+ * boot param if one wants to restore preserved data saved by the =

>>>previously
>>>+ * executing kernel. For that purpose the kernel exports the pfn via
>>>+ * /sys/kernel/pkram. If none is passed, preserved memory if any =

>>>will not be
>>>+ * preserved and a new clean page will be allocated for the super =

>>>block.
>>>+ *
>>>+ * The structure occupies a memory page.
>>>+ */
>>>+struct pkram_super_block {
>>>+=A0=A0=A0 __u64=A0=A0=A0 node_pfn;=A0=A0=A0=A0=A0=A0=A0 /* first elemen=
t of the node list */
>>>+};
>>>+
>>>+static unsigned long pkram_sb_pfn __initdata;
>>>+static struct pkram_super_block *pkram_sb;
>>>+
>>>+/*
>>>=A0* For convenience sake PKRAM nodes are kept in an auxiliary =

>>>doubly-linked list
>>>=A0* connected through the lru field of the page struct.
>>>=A0*/
>>>static LIST_HEAD(pkram_nodes);=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* linke=
d through page::lru */
>>>static DEFINE_MUTEX(pkram_mutex);=A0=A0=A0=A0=A0=A0=A0 /* serializes ope=
n/close */
>>>
>>>+/*
>>>+ * The PKRAM super block pfn, see above.
>>>+ */
>>>+static int __init parse_pkram_sb_pfn(char *arg)
>>>+{
>>>+=A0=A0=A0 return kstrtoul(arg, 16, &pkram_sb_pfn);
>>>+}
>>>+early_param("pkram", parse_pkram_sb_pfn);
>>>+
>>>static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
>>>{
>>>=A0=A0=A0=A0return alloc_page(gfp_mask);
>>>@@ -270,6 +299,7 @@ static void pkram_stream_init(struct =

>>>pkram_stream *ps,
>>>=A0* @gfp_mask specifies the memory allocation mask to be used when =

>>>saving data.
>>>=A0*
>>>=A0* Error values:
>>>+ *=A0=A0=A0 %ENODEV: PKRAM not available
>>>=A0*=A0=A0=A0 %ENAMETOOLONG: name len >=3D PKRAM_NAME_MAX
>>>=A0*=A0=A0=A0 %ENOMEM: insufficient memory available
>>>=A0*=A0=A0=A0 %EEXIST: node with specified name already exists
>>>@@ -285,6 +315,9 @@ int pkram_prepare_save(struct pkram_stream =

>>>*ps, const char *name, gfp_t gfp_mask
>>>=A0=A0=A0=A0struct pkram_node *node;
>>>=A0=A0=A0=A0int err =3D 0;
>>>
>>>+=A0=A0=A0 if (!pkram_sb)
>>>+=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
>>>+
>>>=A0=A0=A0=A0if (strlen(name) >=3D PKRAM_NAME_MAX)
>>>=A0=A0=A0=A0=A0=A0=A0 return -ENAMETOOLONG;
>>>
>>>@@ -404,6 +437,7 @@ void pkram_discard_save(struct pkram_stream *ps)
>>>=A0* Returns 0 on success, -errno on failure.
>>>=A0*
>>>=A0* Error values:
>>>+ *=A0=A0=A0 %ENODEV: PKRAM not available
>>>=A0*=A0=A0=A0 %ENOENT: node with specified name does not exist
>>>=A0*=A0=A0=A0 %EBUSY: save to required node has not finished yet
>>>=A0*
>>>@@ -414,6 +448,9 @@ int pkram_prepare_load(struct pkram_stream =

>>>*ps, const char *name)
>>>=A0=A0=A0=A0struct pkram_node *node;
>>>=A0=A0=A0=A0int err =3D 0;
>>>
>>>+=A0=A0=A0 if (!pkram_sb)
>>>+=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
>>>+
>>>=A0=A0=A0=A0mutex_lock(&pkram_mutex);
>>>=A0=A0=A0=A0node =3D pkram_find_node(name);
>>>=A0=A0=A0=A0if (!node) {
>>>@@ -825,6 +862,13 @@ static void __pkram_reboot(void)
>>>=A0=A0=A0=A0=A0=A0=A0 node->node_pfn =3D node_pfn;
>>>=A0=A0=A0=A0=A0=A0=A0 node_pfn =3D page_to_pfn(page);
>>>=A0=A0=A0=A0}
>>>+
>>>+=A0=A0=A0 /*
>>>+=A0=A0=A0=A0 * Zero out pkram_sb completely since it may have been pass=
ed from
>>>+=A0=A0=A0=A0 * the previous boot.
>>>+=A0=A0=A0=A0 */
>>>+=A0=A0=A0 memset(pkram_sb, 0, PAGE_SIZE);
>>>+=A0=A0=A0 pkram_sb->node_pfn =3D node_pfn;
>>>}
>>>
>>>static int pkram_reboot(struct notifier_block *notifier,
>>>@@ -832,7 +876,8 @@ static int pkram_reboot(struct notifier_block =

>>>*notifier,
>>>{
>>>=A0=A0=A0=A0if (val !=3D SYS_RESTART)
>>>=A0=A0=A0=A0=A0=A0=A0 return NOTIFY_DONE;
>>>-=A0=A0=A0 __pkram_reboot();
>>>+=A0=A0=A0 if (pkram_sb)
>>>+=A0=A0=A0=A0=A0=A0=A0 __pkram_reboot();
>>>=A0=A0=A0=A0return NOTIFY_OK;
>>>}
>>>
>>>@@ -840,9 +885,62 @@ static int pkram_reboot(struct notifier_block =

>>>*notifier,
>>>=A0=A0=A0=A0.notifier_call =3D pkram_reboot,
>>>};
>>>
>>>+static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
>>>+=A0=A0=A0=A0=A0=A0=A0 struct kobj_attribute *attr, char *buf)
>>>+{
>>>+=A0=A0=A0 unsigned long pfn =3D pkram_sb ? PFN_DOWN(__pa(pkram_sb)) : 0;
>>>+
>>>+=A0=A0=A0 return sprintf(buf, "%lx\n", pfn);
>>>+}
>>>+
>>>+static struct kobj_attribute pkram_sb_pfn_attr =3D
>>>+=A0=A0=A0 __ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
>>>+
>>>+static struct attribute *pkram_attrs[] =3D {
>>>+=A0=A0=A0 &pkram_sb_pfn_attr.attr,
>>>+=A0=A0=A0 NULL,
>>>+};
>>>+
>>>+static struct attribute_group pkram_attr_group =3D {
>>>+=A0=A0=A0 .attrs =3D pkram_attrs,
>>>+};
>>>+
>>>+/* returns non-zero on success */
>>>+static int __init pkram_init_sb(void)
>>>+{
>>>+=A0=A0=A0 unsigned long pfn;
>>>+=A0=A0=A0 struct pkram_node *node;
>>>+
>>>+=A0=A0=A0 if (!pkram_sb) {
>>>+=A0=A0=A0=A0=A0=A0=A0 struct page *page;
>>>+
>>>+=A0=A0=A0=A0=A0=A0=A0 page =3D pkram_alloc_page(GFP_KERNEL | __GFP_ZERO=
);
>>>+=A0=A0=A0=A0=A0=A0=A0 if (!page) {
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("PKRAM: Failed to allocate sup=
er block\n");
>>>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>>>+=A0=A0=A0=A0=A0=A0=A0 }
>>>+=A0=A0=A0=A0=A0=A0=A0 pkram_sb =3D page_address(page);
>>>+=A0=A0=A0 }
>>>+
>>>+=A0=A0=A0 /*
>>>+=A0=A0=A0=A0 * Build auxiliary doubly-linked list of nodes connected th=
rough
>>>+=A0=A0=A0=A0 * page::lru for convenience sake.
>>>+=A0=A0=A0=A0 */
>>>+=A0=A0=A0 pfn =3D pkram_sb->node_pfn;
>>>+=A0=A0=A0 while (pfn) {
>>>+=A0=A0=A0=A0=A0=A0=A0 node =3D pfn_to_kaddr(pfn);
>>>+=A0=A0=A0=A0=A0=A0=A0 pkram_insert_node(node);
>>>+=A0=A0=A0=A0=A0=A0=A0 pfn =3D node->node_pfn;
>>>+=A0=A0=A0 }
>>>+=A0=A0=A0 return 1;
>>>+}
>>>+
>>>static int __init pkram_init(void)
>>>{
>>>-=A0=A0=A0 register_reboot_notifier(&pkram_reboot_notifier);
>>>+=A0=A0=A0 if (pkram_init_sb()) {
>>>+=A0=A0=A0=A0=A0=A0=A0 register_reboot_notifier(&pkram_reboot_notifier);
>>>+=A0=A0=A0=A0=A0=A0=A0 sysfs_update_group(kernel_kobj, &pkram_attr_group=
);
>>>+=A0=A0=A0 }
>>>=A0=A0=A0=A0return 0;
>>>}
>>>module_init(pkram_init);
>>>-- =

>>>1.9.4
>>>
>>>
>>>_______________________________________________
>>>kexec mailing list
>>>kexec@lists.infradead.org
>>>http://lists.infradead.org/mailman/listinfo/kexec
>>>
>>
>

-- =

Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
