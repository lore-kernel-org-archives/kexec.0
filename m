Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FFACD1288
	for <kexec@archiver.kernel.org>; Mon,  1 Apr 2024 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=q5A/WY+4HCbfjmEFU2M6xBpprhafLj2w81FU1TQ+J/Q=; b=SMR
	8CXkdGFsF3jpBxY7/T2QWSfkc5L5y2NeOYGEzjZ0d2JcMNPoNcrCPh8EZ0G9zaEngWTSLWld3CGi9
	mvJD2EBaZiDj1p6oN2dTcsLiIOfGSC/KjGSTExTUEHfDiG/zEhNgMb2kz/0qyPiL2SPCMXf1KEGQq
	pimXE0Q0h36H7sLbfB/Hu5nLiC7PKqQgeOWU8eAclmu+zZ145sYjjUFoqIXhpCTqwxlGwqmC+Xrxv
	VRdNOW4D9DCAw1eIr62jAxPRX7K53gw1zfDtJ4lSurIWQuHbot5DmwcCe2ag5NaRZ5gh5wRmi9Jnu
	IRdvdys72BpYleph4vVVovpVv0TYIUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrMZe-00000008aMj-3aJF;
	Mon, 01 Apr 2024 18:40:02 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrMZb-00000008aLn-2W24
	for kexec@lists.infradead.org;
	Mon, 01 Apr 2024 18:40:01 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dc6b2682870so6570513276.0
        for <kexec@lists.infradead.org>; Mon, 01 Apr 2024 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711996798; x=1712601598; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JgMheuDZ9q8sO5WzCyu4uSNRV4Oc3mqdwzajDlVhWIU=;
        b=UzTUJ+Oaz3NHmCw6OvTCOT/BLrbTZNUGHrRe03leysIRjaK2BceqjIrrqWdztlndR+
         hQ7rHEElSSY1zTPEg8HGRSY/3E6UbBvMWx4HlV1OaVgLKjwxgwtC9W+NoSIUcpgyPqqb
         GZEtDHuTFgT+8MjHHfO2BKjjvXQbTsSN1JNenTtxnD/WZEfW0D35fzd7CeqByKsEEUJK
         +BaLVeBr7kOTiepeBdYtQncVJoXoga3TTrpd34WvfC6DFk7b6Lzgpe62q6Km5w0wYMtR
         yGO/4jsC5nUMFWskZXUDtFtcSEu2Usw0mVkuq9d987il9PpDsWjUgFAtNKQUX/H0c2aG
         mBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711996798; x=1712601598;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgMheuDZ9q8sO5WzCyu4uSNRV4Oc3mqdwzajDlVhWIU=;
        b=VieW1Xsd1QqsMA8u9Iyyr7xxEQCp7GcOU3Qd0rnrg19R9vknxZ/gbpAhQkvFlZLpsv
         0Q3ziPImqsL2RYhYZgBneam3HJADmk4ZJK+gjc0Ae131zfMn2lQuQVEkoWXZ/f560PbY
         bbAKdzW5UIkXruEehW4XAk2T1VOQ0NhJHCCkWiO+2aPu66selcKIIHWa61RN3ypE9LlR
         NBLyWrmeTa8NNEZwwEAg/9spC4gX+kiUdAV/djeuQiumAHqcKYElRGwQjXWusvkXrkPO
         kfr0E4ozdJtnBn+CCypNNtVEcfA3bdWyti3ebevW/Nbor5AfWS0TdfRHAffgOS55MN/Y
         t3rA==
X-Gm-Message-State: AOJu0YwWjrXpskwSsQqDW/LQDkQQ7e/Zz6YWqGGGiijnlojMMTWUO4el
	SgeYRDbIFA961GVlEVvRAdRPeGoKLaeOhQ9h3GDFhF78XK6OsbOY/ej6Jho4EpxE6pK2Jtqg52l
	L4a88rWWxHM5o1/mKxeB3FA==
X-Google-Smtp-Source: AGHT+IHSmFegPY5LrkmIhHmV2aW8Fujix6RmCEZ5xbkPgSlx7/Qdn60CtjV4+JrWRC8OnVdY8bMiErkNetC/FspRww==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1893:b0:dc6:fec4:1c26 with
 SMTP id cj19-20020a056902189300b00dc6fec41c26mr3327875ybb.1.1711996797754;
 Mon, 01 Apr 2024 11:39:57 -0700 (PDT)
Date: Mon, 01 Apr 2024 18:39:55 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHr/CmYC/42NTQqDMBBGryKz7pQk/VG66j2KCxMnMVAdmUioi
 Hdv6gm6fA++922QSCIleFQbCOWYIk8FzKkCN3RTIIx9YTDKXNXF1JgWmdy8ok84CzvMo2MhdGh
 109d37akjD2U+C/n4OdKvtvAQ08KyHk9Z/+wf0axRIylzo141Vlv1DMzhTWfHI7T7vn8BS8M/5 cEAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711996796; l=2314;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2MbhgQj8cVkDP038ndgOY503dVX+Ax4mZCM7tpCQcQA=; b=QK8nLukocBQU9jplQm8cs3ucevtjDWazF2fw9lAMxYf+e9BuLtUEVXrqzKXK3RvJsRteZolGw
 XJfs74WA4giCbUveTWR8xEsOJ1EhMVcg46SafcYUkIELkNIvOLYJBFW
X-Mailer: b4 0.12.3
Message-ID: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
Subject: [PATCH v2] vmcore: replace strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240401_113959_905585_68D9A58D 
X-CRM114-Status: GOOD (  12.80  )
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

strncpy() is in the process of being replaced as it is deprecated [1].
We should move towards safer and less ambiguous string interfaces.

Looking at vmcoredd_header's definition:
|	struct vmcoredd_header {
|		__u32 n_namesz; /* Name size */
|		__u32 n_descsz; /* Content size */
|		__u32 n_type;   /* NT_VMCOREDD */
|		__u8 name[8];   /* LINUX\0\0\0 */
|		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
|	};
... we see that @name wants to be NUL-padded.

We're copying data->dump_name which is defined as:
|	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
... which shares the same size as vdd_hdr->dump_name. Let's make sure we
NUL-pad this as well.

Use strscpy_pad() which NUL-terminates and NUL-pads its destination
buffers. Specifically, use the new 2-argument version of strscpy_pad
introduced in Commit e6584c3964f2f ("string: Allow 2-argument
strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- don't mark buffers as __nonstring, instead use a string API (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/proc/vmcore.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..5d08d4d159d3 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
 	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
 	vdd_hdr->n_type = NT_VMCOREDD;
 
-	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
-		sizeof(vdd_hdr->name));
-	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
+	strscpy_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME);
+	strscpy_pad(vdd_hdr->dump_name, data->dump_name);
 }
 
 /**

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
