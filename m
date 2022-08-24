Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25E6C32796
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qjL60r2T7n7hOwNRO1qdBqiAriO+HETHjT7+JWlqD2M=; b=IwjWYiUtUBTUKr
	88XQqjloWKda8SvN3hNWhlYY15CpqN1QTVdWJ3UChhKEzLyI5ozgy7CCegKJ0pLZOZNGMVzXS5eih
	7rbnxPoOSADK8N/s8m2ZQD3q/M6VDVZEfPOzHMLAcUnPMd1ptHX/EC0iX0EJnOgbbi2io+nONn5MA
	LrtLK0Y1ruO5Nq5RZ19LWPEB2vhl6SbWnzVYkMV05I+LbKE+IXUI7RUOAF0YpKlBp1iCBwrR28GqN
	YPD+fBoo5gLtZcO+hz+Yy5XeapYg+4qLbmeHVwnuOA/X9zolE4JKWfm6buoeFpprze8mh2ESjPhbv
	K4UfXZbJZ3X/GpeFHaUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQtHm-00EQm2-2r; Wed, 24 Aug 2022 16:31:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQtHj-00EQjV-65
	for kexec@lists.infradead.org; Wed, 24 Aug 2022 16:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661358678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXUvPXR+b9lqF8hwT6ic9kgmL6Hea0lIAs1c1MqWYvI=;
	b=Yn8RmJZfrerJVOXwNn6g6Ly4TiLU9hv1swfdAmw+EaIVR3RsoDGANuoY46weDECwivXqTP
	eZX3gXM7b9s5waqPy6cK7ac7bF4L0V3KR97hFEV8fKDZh/W8UU3U9cub6nBSAthH+PEsE2
	9WboibqG/JAcdVFoEg79+6rPcXDH/m8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-SCBzPGAuN0qxwGul-CpxkQ-1; Wed, 24 Aug 2022 12:31:14 -0400
X-MC-Unique: SCBzPGAuN0qxwGul-CpxkQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 140248039A1;
	Wed, 24 Aug 2022 16:31:14 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9EF3840315A;
	Wed, 24 Aug 2022 16:31:10 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH RFC 2/2] checkpatch: warn on usage of VM_BUG_ON() and friends
Date: Wed, 24 Aug 2022 18:31:00 +0200
Message-Id: <20220824163100.224449-3-david@redhat.com>
In-Reply-To: <20220824163100.224449-1-david@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_093119_320739_0029A7C2 
X-CRM114-Status: GOOD (  15.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

checkpatch does not point out that VM_BUG_ON() and friends should be
avoided, however, Linus notes:

    VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
    no different, the only difference is "we can make the code smaller
    because these are less important". [1]

So let's warn on VM_BUG_ON() and friends as well. While at it, make it
clearer that the kernel really shouldn't be crashed.

Note that there are some other *_BUG_ON flavors, but they are not all
bad: for example, KVM_BUG_ON() only triggers a WARN_ON_ONCE and then
flags KVM as being buggy, so we'll not care about them for now here.

[1] https://lore.kernel.org/r/CAHk-=wg40EAZofO16Eviaj7mfqDhZ2gVEbvfsMf6gYzspRjYvw@mail.gmail.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..4c18acf17032 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4695,12 +4695,12 @@ sub process {
 			}
 		}
 
-# avoid BUG() or BUG_ON()
-		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
+# do not use BUG(), BUG_ON(), VM_BUG_ON() and friends.
+		if ($line =~ /\b(?:BUG|BUG_ON|VM_BUG_ON|VM_BUG_ON_[A-Z]+)\b/) {
 			my $msg_level = \&WARN;
 			$msg_level = \&CHK if ($file);
 			&{$msg_level}("AVOID_BUG",
-				      "Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()\n" . $herecurr);
+				      "Do not crash the kernel unless it is unavoidable - use WARN_ON_ONCE & recovery code (if reasonable) rather than BUG(), BUG_ON(), VM_BUG_ON(), ...\n" . $herecurr);
 		}
 
 # avoid LINUX_VERSION_CODE
-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
