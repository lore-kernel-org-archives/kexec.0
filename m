Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6854BC6FD1D
	for <kexec@archiver.kernel.org>; Tue, 21 Mar 2023 16:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:MIME-Version
	:Subject:cc:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jk/6Z73uWwH9hE/Zr7TI2h7AbhdUP71qsis/JzC5MYc=; b=hZ5w0+ZkdaYSiS
	JyrSXTKD+uUqlUJP/3m16TZnUvOwQD+AIuqcAMBbq/L+yEUtBK1ULpWBFeAVP+VEz5o8D3/FtKmeP
	IN9zBMiJ6yhl2JiJK6F94gj1dMJ6e+nSGQ0s5bntTMsF+QtfuyUsvbxbkj7f0Px4oStMQjvotdYDe
	8t4BN2hr8Rpaodk0BLX37oIQ2XwN+hN+96OX/+VGDcJ7EpYA5qZvlNK+2KQfQ5EZKICSdoup/pRYI
	sQu9zMmT0L+Si7SR3lTIMjeLOpCu09HKpUbRHFqcuA5v1EcaIdFuWd91MGe9R1F3AcOCLSvOrV02+
	XfkYlTuHkASzEsr0m4KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pef5c-00D73w-0X;
	Tue, 21 Mar 2023 16:44:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pef5Y-00D72d-1U
	for kexec@lists.infradead.org;
	Tue, 21 Mar 2023 16:43:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679417034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ni73P6iOwq/z06Tc9mCMwHkprsEWFzyatJbBnmGE7Q8=;
	b=bW23Rr5AailFgtwT60kAfpbXLjb/HJMo3cM83ZG9gEiVXVKHRXot5DkU8WgBcbxVDtPTLg
	g8IMtufVPSRCHiQJ5XXzKLm7aeyK4bhW6JS0X2fwZ/GZL3iEwl00jWQ/Qdas72eFjrmim7
	csl2rLsdyaGvnup2Cfz+ksbxqYBxWsk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-qaZqdp-zNrahOBtwB2l9Lg-1; Tue, 21 Mar 2023 12:43:52 -0400
X-MC-Unique: qaZqdp-zNrahOBtwB2l9Lg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F6FC101A54F;
	Tue, 21 Mar 2023 16:43:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 637B3492C13;
	Tue, 21 Mar 2023 16:43:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
    Bharath SM <bharathsm@microsoft.com>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Steve French <smfrench@gmail.com>,
    Robbie Harwood <rharwood@redhat.com>,
    Eric Biederman <ebiederm@xmission.com>,
    Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org,
    linux-cifs@vger.kernel.org, linux-crypto@vger.kernel.org,
    kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [GIT PULL] keys: Miscellaneous fixes/changes
MIME-Version: 1.0
Content-ID: <2851035.1679417029.1@warthog.procyon.org.uk>
Date: Tue, 21 Mar 2023 16:43:49 +0000
Message-ID: <2851036.1679417029@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_094356_574297_FC6F4B3C 
X-CRM114-Status: GOOD (  19.11  )
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

Hi Linus,

Could you pull these fixes/changes for keyrings?

 (1) Fix request_key() so that it doesn't cache a looked up key on the
     current thread if that thread is a kernel thread.  The cache is
     cleared during notify_resume - but that doesn't happen in kernel
     threads.  This is causing cifs DNS keys to be un-invalidateable.

 (2) Fix a wrapper check in verify_pefile() to not round up the length.

 (3) Change asymmetric_keys code to log errors to make it easier for users
     to work out why failures occurred.

Thanks,
David
---
The following changes since commit fc89d7fb499b0162e081f434d45e8d1b47e82ece:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2023-03-13 10:43:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-fixes-20230321

for you to fetch changes up to 3584c1dbfffdabf8e3dc1dd25748bb38dd01cd43:

  asymmetric_keys: log on fatal failures in PE/pkcs7 (2023-03-21 16:23:56 +0000)

----------------------------------------------------------------
keyrings fixes

----------------------------------------------------------------
David Howells (1):
      keys: Do not cache key in task struct if key is requested from kernel thread

Robbie Harwood (2):
      verify_pefile: relax wrapper length check
      asymmetric_keys: log on fatal failures in PE/pkcs7

 crypto/asymmetric_keys/pkcs7_verify.c  | 10 +++++-----
 crypto/asymmetric_keys/verify_pefile.c | 32 ++++++++++++++++++--------------
 security/keys/request_key.c            |  9 ++++++---
 3 files changed, 29 insertions(+), 22 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
