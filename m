Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D61EC4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 02:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lR6HlwrnOalxkbmJSzZ6Bqoi3Go8WP4OJv/NsvxyORw=; b=AXcVQ1U5N4NwU9
	+I89q6lx4uvATQwuiTignI9jU4N6F7h4I3mXf+DFq2YTQsZOcdvVjIGIhYqwEhSdcqL5KxrbeXUiV
	twbnJOlg8wZZ3PF2edvE3wvbxu2pw29yj1QpejTwD5MVE/YcOjZvYGJHZY/VJNbNODa02od4mpzCs
	+kY/q2T+w4ndtxiGG6VyEmKWEY1XX5SagvlWpdg1KeLy372UMrxEvLh1Lo0FTYJ3ukvlGEeLRYOyE
	VrrHS6NctW9sxabc1VNnrNU1pFi3I0N00RA2dn4X79DC1n6kpcTTDUEb/a3F5PfsSO9iEgs+fDR7w
	evYqm9sK60hDlIheSsIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzSFr-00000002Aj4-1rJZ;
	Wed, 24 Apr 2024 02:21:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzSFl-00000002AgB-2h6j
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 02:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713925254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1LyeIxCCGUt+I5uSBdtXZjz+D9O46gAeCiyKIMOQngc=;
	b=U4y+FywdU4QFNF4PDooqDlnif1bIkEc7keAEx6bm5S4YUEzN8J1Bs/mxQsLosSeNP2t7Yu
	4p4tIzNc1G0hufWjPDF1sZ1KnQ8dyLwUf9s0/3JXFRA/UzUagJxLyWzbHAV8NSu/k2kCu5
	WLUjNxkrJII5jDIOrrgrFVYddOYS3T0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-RYpt-d7OO6KwxBUcCh6VQA-1; Tue, 23 Apr 2024 22:20:52 -0400
X-MC-Unique: RYpt-d7OO6KwxBUcCh6VQA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6efef492e79so7725073b3a.1
        for <kexec@lists.infradead.org>; Tue, 23 Apr 2024 19:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713925251; x=1714530051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LyeIxCCGUt+I5uSBdtXZjz+D9O46gAeCiyKIMOQngc=;
        b=d2/pQq1eReinRLlatsIb0y1rZH1NnlLYaL0qJISFVjt4JpZ4UD2lYP530W6GlWi9Fj
         7kn2KHPCpjkvZ185ue4UGTNk7fRJifeuNwrZ8HGL9S3hIrhFfIbOas3tj8SvbWrqhJvH
         Ja3fWGHiFABCjMmDlUFjeXEB10GgTam+YWf/wo8AgdwNXts4yKj+L1qZdJhiF1VtFbh/
         AIo0Ku/iu7YTvJOkchXbU7FQBVd4ttzCI3XVY6o3AXJzLH9NWicObd1tc9pyurE9bDTo
         Bgey5nuU3C79lbTCnJI14g9dkVwipKg15WprlHRTPyjC+ZvBLo6WkCUF76wOUcU3k7u3
         k0CA==
X-Gm-Message-State: AOJu0YzHXXgE2k29U/YC5uTvFpqpPZcGrFUTdP+Uuw/Fi8ie6FLwLEu3
	vMoL3UwNA0+ThBnZRWpjS32iZmVYabmxSr8kclB7w3cMsNsl7gKy33f2e+L8KSVxr3WylqcBemV
	nKSXgzYNJBoqQVbZOCbugYg6m8FJYaoPb67A4pOXXgr4fmcypqw3r1B2x6H6nqM6HzJmMt989xU
	b2cVFhwN9G94X8ntV9c7pzaSnPwR7sDoPG/NgjDYmj9g==
X-Received: by 2002:a05:6a20:5b14:b0:1aa:58d9:18fa with SMTP id kl20-20020a056a205b1400b001aa58d918famr1023438pzb.48.1713925250443;
        Tue, 23 Apr 2024 19:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK5NccKyNYT4w6z9u9k5887FQOPQozCUqJkIdNrGqQs0crrtmummSerAmP05FqANzlFcF25w==
X-Received: by 2002:a05:6a20:5b14:b0:1aa:58d9:18fa with SMTP id kl20-20020a056a205b1400b001aa58d918famr1023421pzb.48.1713925249565;
        Tue, 23 Apr 2024 19:20:49 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090aae0100b002a2d8d34009sm11846164pjq.27.2024.04.23.19.20.48
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:20:49 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Subject: [PATCH makedumpfile] Make sbindir configurable
Date: Wed, 24 Apr 2024 10:20:47 +0800
Message-ID: <20240424022047.13325-1-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_192058_017155_8FFEAA1C 
X-CRM114-Status: UNSURE (   7.78  )
X-CRM114-Notice: Please train this message.
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

Fedora is going unify bin and sbin and /usr/sbin directory will become a
symlink to bin [1]. So make sbindir configurable to support this case.

[1] https://fedoraproject.org/wiki/Changes/Unify_bin_and_sbin

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 55c9c7a..0cd2b03 100644
--- a/Makefile
+++ b/Makefile
@@ -101,6 +101,8 @@ LINK_TEST_PROG="int main() { return 0; }"
 LIBS := $(LIBS) $(call try-run,\
 	echo $(LINK_TEST_PROG) | $(CC) -o "$$TMP" -x c - -lebl,-lebl,)
 
+sbindir ?= /usr/sbin
+
 all: makedumpfile
 
 $(OBJ_PART): $(SRC_PART)
@@ -126,8 +128,8 @@ clean:
 	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 makedumpfile.conf.5
 
 install:
-	install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
-	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
+	install -m 755 -d ${DESTDIR}/${sbindir} ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
+	install -m 755 -t ${DESTDIR}/${sbindir} makedumpfile $(VPATH)makedumpfile-R.pl
 	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8
 	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5
 	mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
