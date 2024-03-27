Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6049FC47DD9
	for <kexec@archiver.kernel.org>; Wed, 27 Mar 2024 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=00sQBgbZH8W8m3jW4sLCR4MltrrLRH4jghVrOP5QDRI=; b=h/B
	TzPt6VrsMu63vYr+iNqHT6nr7byD6/oR9G04Vdo/qYTPcpclmDnXORobQI8DzXMV9dHRDf2KfAA+Y
	3vEMzjofE/5AG+2TkLfCaDr7GCCq/z/Hm5rnVOi3WnCA554fujxGwJOW/Bs9H8GpFfbzcO/R+PGKG
	Dzk+3kedbPX8Vy4EnzwsA3hK/XbMUxa2PVAytheIbPRqSsl4Geu8HLUjQ1y2v822cdVr+Tp1BCzYP
	R5Hoy9DY9xk1rOki8xVso5HmteO/A0OPkQJBEoeY3pEQbMwwKJkg4+z91eVaN4967s6CidSU+rZZt
	WDe/aWK1k5ROim7Op63XUYZEolxsW+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpaY1-0000000BACK-3ju5;
	Wed, 27 Mar 2024 21:11:02 +0000
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpaXy-0000000BABV-1U7D
	for kexec@lists.infradead.org;
	Wed, 27 Mar 2024 21:10:59 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso403207276.3
        for <kexec@lists.infradead.org>; Wed, 27 Mar 2024 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711573854; x=1712178654; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+lkMVelOezh/ZlXJ0pLzE+PWawOJ1uDpRCeivCwpFfI=;
        b=t/jO55yu5VpzRh+sTYyAvBzayQYg7qHjgE1YcCHV6ThIrCbckaF6bODjxJg9I5LLCq
         m0a6lVm1thHefLZS1QxMNyg+jugyQeDJkQIanG5834ZeKqOzLMc4qeaPbzgdEXU3k/sn
         oQNFeNGyyGUgxke62A0A7SaZRQGqQ1X8MCoHPuU/SaDhUecJREAqv8bhy5p++5O2FSfr
         aysqz5VwLB77zFzK0dhEWTW2eL0/cM8PIQy5pk5Szl8Bd5CZGBrEMzMsqlghpGZAWTq/
         klFWeTXFxdR4vrLNAdWofo/YUFoqUfYo7YbN4qU6YMA7MIKfRAhyRpbS62SS9xq6SZrq
         1IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711573854; x=1712178654;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+lkMVelOezh/ZlXJ0pLzE+PWawOJ1uDpRCeivCwpFfI=;
        b=p5uuf86a3V2UDEWBq1wmjLkAXWKcvatY23NvIGkferwNtIhtv6wGZYPuoS+9l9oYqT
         WBUpKfi0flhp9OJBfmdkB5XJHJdiMjNcU2d7+RuamKG+oJJqdJ5TfZLNqoqwuDBFWcOm
         rSR2/nesb9fQmycSEEpzZUZVTabeczdmBGIko7TPchUsr8yMIslh70R09d8thmJ3ZIiI
         +JoL4eCcEOwrq/qTStTIfmSrzqwVF9XSb6uR4uXajIZZQqax6eXbVaCyiv5D1Xe45QzG
         93KCTZGXA3mBDAiYVL6hd9cvRs4TYEBir/Skmj1EfM0TYfd3gGB3qT95lp1zTlBEgZz1
         eHXw==
X-Gm-Message-State: AOJu0YxlcyH8jzeESDB4sHvg/5ssKKnnpBpegabhky/P7IkpA0j70tt7
	fyiI4ckpcYjzDb54hvOiZOyaPu/H4mz1zaigz4ohy6hdY7w4h3ejoIHaH03Q8dcQ5Tvi7rIpaTh
	GL3l+37w3dV5Vea4esIsuuA==
X-Google-Smtp-Source: AGHT+IF2W4CfyY1W2KI8dpvyaTKLJ22XNKhwxs5DcbfYiSRg/rNYQ2xBm+UlXjsQKvrjcxKStDc5WbID/PhFU2jObA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1009:b0:dc6:ff2b:7e1b with
 SMTP id w9-20020a056902100900b00dc6ff2b7e1bmr325202ybt.4.1711573854514; Wed,
 27 Mar 2024 14:10:54 -0700 (PDT)
Date: Wed, 27 Mar 2024 21:10:52 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFuLBGYC/x3MwQqDMAyA4VeRnA3YTqb4KuLBxXTLYW1JpCjiu
 6/s+B3+/wJjFTaYmguUi5ikWOHaBuizxjejbNXgO993Dz+g7RopnxgMsybC8qWkjIQvN27D0wV eOUDNs3KQ47+el/v+AZI+IAhqAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711573853; l=2631;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=c05JlIhAAX9+Wj5KD5xjyuKpqsfoj6wU7p1hNY3Smz4=; b=dvoo077PNzidPJkbn13FOfdETuWck8T+nbUCWDn79wP+pUbOIiqdMGPeDBqCc5kqKPcrChbca
 T5lNI9lENkhAMdr88HffzjhBqJSvVobkKfzQHKHkcprOU1eF+49l098
X-Mailer: b4 0.12.3
Message-ID: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com>
Subject: [PATCH] vmcore: replace strncpy with strtomem
From: Justin Stitt <justinstitt@google.com>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_141058_471280_B73B0589 
X-CRM114-Status: GOOD (  13.93  )
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

strncpy() is in the process of being replaced as it is deprecated in
some situations [1]. While the specific use of strncpy that this patch
targets is not exactly deprecated, the real mission is to rid the kernel
of all its uses.

Looking at vmcoredd_header's definition:
|	struct vmcoredd_header {
|		__u32 n_namesz; /* Name size */
|		__u32 n_descsz; /* Content size */
|		__u32 n_type;   /* NT_VMCOREDD */
|		__u8 name[8];   /* LINUX\0\0\0 */
|		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
|	};
... we can see that both `name` and `dump_name` are u8s. It seems `name`
wants to be NUL-padded (based on the comment above), but for the sake of
symmetry lets NUL-pad both of these.

Mark these buffers as __nonstring and use strtomem_pad.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/proc/vmcore.c            | 5 ++---
 include/uapi/linux/vmcore.h | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..5d7ecf3b75e8 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
 	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
 	vdd_hdr->n_type = NT_VMCOREDD;
 
-	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
-		sizeof(vdd_hdr->name));
-	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
+	strtomem_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME, 0);
+	strtomem_pad(vdd_hdr->dump_name, data->dump_name, 0);
 }
 
 /**
diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
index 3e9da91866ff..7053e2b62fa0 100644
--- a/include/uapi/linux/vmcore.h
+++ b/include/uapi/linux/vmcore.h
@@ -11,8 +11,8 @@ struct vmcoredd_header {
 	__u32 n_namesz; /* Name size */
 	__u32 n_descsz; /* Content size */
 	__u32 n_type;   /* NT_VMCOREDD */
-	__u8 name[8];   /* LINUX\0\0\0 */
-	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
+	__u8 name[8] __nonstring;   /* LINUX\0\0\0 */
+	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES] __nonstring; /* Device dump's name */
 };
 
 #endif /* _UAPI_VMCORE_H */

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240327-strncpy-fs-proc-vmcore-c-b18d761feaef

Best regards,
--
Justin Stitt <justinstitt@google.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
