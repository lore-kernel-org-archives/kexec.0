Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7C3E65D3F
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jBafrgP5HxGm/QDUZj/NqLP1VcubbKCnQ9XDzhE9RrE=; b=n3r4PEtFuFx5ibg1duYHmR5cwb
	YQ+AyvgFoctQTvD6FSWgAsnA/R2sjHeOj2Z8HA8CoLoVffn/49hl+eqnrNJ2QZZ0UO1V56IWP3xhQ
	AUaLfMHRsGjtqq2fERzYB9m3KO6FObhEPN3jjbhXUkxOedlIccAj761vOc9glaoas66KnEkRVsZxu
	umFpZ0soG3YSJLaEbdO5InqBduMSdLNWOlrPD+q1pUE19WfQFmfQ3TuZGqgBAFoUjgc753u/ooNuu
	gigw/ndT/giKN+xAWPeUOCdjxImDLCZ/XrT+iI+5L+c5U9hSDMaRvR4bjVT3t53HuqV3zuYgZbN+c
	qS9ZZi5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEQnr-00000002Es1-11K6;
	Fri, 22 Nov 2024 10:22:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEQeK-00000002DYX-2E8E
	for kexec@lists.infradead.org;
	Fri, 22 Nov 2024 10:12:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732270347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jBafrgP5HxGm/QDUZj/NqLP1VcubbKCnQ9XDzhE9RrE=;
	b=bIeKT3CQYPnPqt1ZCuTtObW0u0N/TB5dQ47ruuZe5HA4m11uacenz9wy34WG88iQuYfJkp
	d+tgx9rOZCff2r3VMf6woOehJwy61d3Z/L6GpEHIzRfzN1nVNa3H4YQbA48KayeeMZ7X1G
	At5ohuDg+NVBKnslNGaRMZz7rBmFAp8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-M3OJm6p8O0KqWWwQY26wxA-1; Fri,
 22 Nov 2024 05:12:25 -0500
X-MC-Unique: M3OJm6p8O0KqWWwQY26wxA-1
X-Mimecast-MFC-AGG-ID: M3OJm6p8O0KqWWwQY26wxA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30A6C1955F69;
	Fri, 22 Nov 2024 10:12:24 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.64.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5E3230000DF;
	Fri, 22 Nov 2024 10:12:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: kexec-ml <kexec@lists.infradead.org>
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Masamitsu Yamazaki <yamazaki-msmt@nec.com>,
	Kazuhito Hagio <k-hagio-ab@nec.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v1] makedumpfile: fix detection of typed (compound) pages (Linux 6.12)
Date: Fri, 22 Nov 2024 11:12:19 +0100
Message-ID: <20241122101219.936746-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fiof5GODxh85WoB3LlWFbAT_OiA2a1JxiQIHCFngtSU_1732270344
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_021228_638087_8D6CE6C0 
X-CRM114-Status: GOOD (  15.93  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Ever since kernel commit 4ffca5a96678c ("mm: support only one page_type
per page"), page types are no longer flags (PG_slab, PG_offline, ...)
stored in page->_mapcount, but values stored in the top byte.

Because we currently try deriving flags from the mapcount values to
check for slab and hugetlb pages, we get:
(1) "false positives" from isSlab(), making us not detect free (buddy)
    pages and offline pages anymore.
(2) "false positives" when detecting hugetlb pages.

In the common case we now simply dump all memory, and fail to exclude
offline and free (buddy) pages, assuming they are all slab pages,
which is bad.

We should just consistently compare the page->_mapcount with the unmodified
PAGE_*_MAPCOUNT_VALUE, like we already did for free (buddy) and offline
pages already. This also works for older kernels, because the kernel never
supported having multiple page types set on a single page, so there was
never the need to derive flags from the PAGE_*_MAPCOUNT_VALUE.

It is worth noting that the lower 24bit of the page->_mapcount field
can be used while a page type is set. This is, however, currently not
the case for any of the involved page types (slab, buddy, offline,
hugetlb). In the future, the kernel could either just tell us the types,
or provide a mask to be applied to the page->_mapcount ("bits to ignore")
when comparing the values. But, there might be bigger changes coming up
with the "memdesc" work in the kernel, where the type would not longer
be stored in page->_mapcount ... so for now we can keep it simple.

Link: https://github.com/makedumpfile/makedumpfile/issues/16
Cc: Masamitsu Yamazaki <yamazaki-msmt@nec.com>
Cc: Kazuhito Hagio <k-hagio-ab@nec.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 makedumpfile.c | 6 ++----
 makedumpfile.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b356eb3..bad3c48 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -280,8 +280,7 @@ isSlab(unsigned long flags, unsigned int _mapcount)
 {
 	/* Linux 6.10 and later */
 	if (NUMBER(PAGE_SLAB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
-		unsigned int PG_slab = ~NUMBER(PAGE_SLAB_MAPCOUNT_VALUE);
-		if ((_mapcount & (PAGE_TYPE_BASE | PG_slab)) == PAGE_TYPE_BASE)
+		if (_mapcount == (int)NUMBER(PAGE_SLAB_MAPCOUNT_VALUE))
 			return TRUE;
 	}
 
@@ -6549,11 +6548,10 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 			 */
 			if (NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
 				unsigned long _flags_1 = ULONG(addr + OFFSET(page.flags));
-				unsigned int PG_hugetlb = ~NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE);
 
 				compound_order = _flags_1 & 0xff;
 
-				if ((_mapcount & (PAGE_TYPE_BASE | PG_hugetlb)) == PAGE_TYPE_BASE)
+				if (_mapcount == (int)NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE))
 					compound_dtor = IS_HUGETLB;
 
 				goto check_order;
diff --git a/makedumpfile.h b/makedumpfile.h
index 7ed566d..2b3495e 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -164,8 +164,6 @@ test_bit(int nr, unsigned long addr)
 #define isAnon(mapping, flags, _mapcount) \
 	(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(flags, _mapcount))
 
-#define PAGE_TYPE_BASE		(0xf0000000)
-
 #define PTOB(X)			(((unsigned long long)(X)) << PAGESHIFT())
 #define BTOP(X)			(((unsigned long long)(X)) >> PAGESHIFT())
 
-- 
2.47.0


