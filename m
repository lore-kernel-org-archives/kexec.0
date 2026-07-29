Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF7FC53200
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QRr6uTm0B+MLoKOJmLgia92uvD3SNG7zn6UrSIRNrb0=; b=CmGJKhLOxMCITP+1FViaoUTQoH
	02Inec0SKqoJrJN+ryb6NqUQmMSmecJljWdkEdQ8ICGjC3FbvfVr8P1gyKqaeg/ee4fruOyRKh/to
	IkyznV9jrHD6eQxMO2gYakclhvP38iQw+tqOwqMhbMjnuN+HzsutNGUe4lusulbvxOjWCWCT130YQ
	NrRfYq/wwzB5H4LjYUWG+d27wePSyrYqm2gdx3sXU6ZQ8vY16eFz61+aErDUgU7m/Syn80hoMx6to
	Z+L2p+EcrHmQlYmP0c/8USc+OQ+N1o3jUGiRkZJ+CHznsf7hLRRwUJfvG/Ft9xC+un+fw90bB9Ime
	6x92QTeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6c-00000006lRn-1DtQ;
	Wed, 29 Jul 2026 03:37:18 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6Z-00000006lQB-0NYG
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:16 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-848761b5897so283500b3a.3
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296234; x=1785901034; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRr6uTm0B+MLoKOJmLgia92uvD3SNG7zn6UrSIRNrb0=;
        b=RqP9fjH92ZneUBXfWaoEvhuJpUQl+6COfwYAIOWAGqtIs+eANztX7HUYXt1DktseNQ
         mscWgQGbNOsSeR8329SRrxkWFC+DAYLVhQ/9vZsKC8CyZJjwS2WRxERW+hsFfoV3w0ci
         fcNPvyJf8nLWCJB8fO6Y3eLy1ePoweepAE8PZijI1j/MJNMOLoP3hQJxN0MpUcg4zTWC
         1rjxC62xzWnAv6fhNDhBN6grxk0qUO5prKsQ8vWbsAgh1pzDbp1KoikQe+l6PR72vChC
         uMU5AQ5yuNnSkRQpwwSs8Btea/e/fwYmS2cF6ZaoxZQB+gNrlacxykFD8+hbMEkyCs/5
         vhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296234; x=1785901034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QRr6uTm0B+MLoKOJmLgia92uvD3SNG7zn6UrSIRNrb0=;
        b=iIzbSVwnn7ToM52eIVr+Rg4ATsPqSBxj/mUP52oLpo/cTs8n0D11rySMmOcdJzXrx5
         LKgX1lrMrmgBI8yaXwrlXdkKBN8I5UAogKUC24J6tdynJ6ubUSdsCTe3/LNuNAV81SYw
         YbqxaL5PyWqIjdNimrRuFJ6rk6ZDNDM+0HQEpqRS4yVY5Ki/flrIyRTCxTovL84y3LNV
         sHils9o4IcdiEQDb7pqTEtMl5Hx+8NNbkVOv9hcXuO74gLpAk+aYfF/8V4U/Y1WgXF20
         si6rgppW7pmLL1O/X8zQ7QfpHd0AgV1pxOyCT3Z3UZrv44VPokqoWNNfbSJinNOD8Fjt
         DRFg==
X-Gm-Message-State: AOJu0YxJ2m0Tpnqr7WNmgQg2Ln/f1UP5w2cygkM0B9cGI2nD3s96CyHa
	W9wkfM5uzXRZ3KRWHIA1+Ta3qqVMw1ZWmHOVerwd/B17S5YZ6orzsXZ7jERLznfXn1fdzw==
X-Gm-Gg: AR+sD118wuGv2oUVARtNHyb38sYJbHLqFHi5ljtayGNgqzCTMwgtYQEAqFasRg7xPmp
	v3Dqho5/AdLXRjXQsm9CRfFT5JaOjNthGE5Q0FZfQCKzZ7cSutY1dWcd2Cc3uSFRkuBAJOSHBuZ
	4HiCVtZoMEZVbpl/WaFsT7oY4VKSRqLnd3VZPFY0dL8Ji7zo8SeHMbUt25riTIVa7escGVF/n+B
	9I0kBRGpvrqYyLK1HeMmZzpMPAu5E4OvuE13Z+LFzUJJW/ye9ST4pfzGX3fQTXtzyDtdpBv0Mlw
	xLfyywZ0bkEIf6+8PHde3ZqchV/6GX00r8X5dFIzom1b9LdxhyJXfb5KBNXIxdRk/7Tnj3uvH4e
	svOcfSRwPNVK2etPouzQoGJhI6g96xA+ehwDGmmEqER6YTSL21GNIrtTtpD+4/PLsFkGpWDT/dz
	vYcwLwz12fxRCuMkQZVpudi/OQsPEeEsbh2juJguc7jJg=
X-Received: by 2002:a05:6a00:2d02:b0:847:8be6:2177 with SMTP id d2e1a72fcca58-84e93290137mr5157865b3a.34.1785296234112;
        Tue, 28 Jul 2026 20:37:14 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f3:1e14::2ff:1d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03869d2sm662551b3a.49.2026.07.28.20.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:37:13 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/10] crash_dump: Read the number of dm-crypt keys from reserved memory
Date: Wed, 29 Jul 2026 11:36:44 +0800
Message-ID: <20260729033654.311541-5-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729033654.311541-1-coiby.xu@gmail.com>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203715_136196_C543ECF8 
X-CRM114-Status: GOOD (  14.76  )
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

In case user adds/deletes the keys by mistake, it's safer to read the
number of keys from reserved memory.

Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Reported-and-Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index d2e66c6fe6f3..a3996208738b 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -88,21 +88,31 @@ static int get_keys_from_kdump_reserved_memory(void)
 {
 	struct keys_header *keys_header_loaded;
 	size_t keys_header_size;
-
-	keys_header_size = get_keys_header_size(key_count);
-	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
-	if (!keys_header)
-		return -ENOMEM;
+	int r = 0;
 
 	arch_kexec_unprotect_crashkres();
 	keys_header_loaded = kmap_local_page(pfn_to_page(
 		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
 
+	if (keys_header_loaded->total_keys <= 0 ||
+	    keys_header_loaded->total_keys > KEY_NUM_MAX) {
+		pr_warn("keys_header saved to reserved memory may be corrupt\n");
+		r = -EINVAL;
+		goto kunmap;
+	}
+
+	keys_header_size = get_keys_header_size(keys_header_loaded->total_keys);
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header) {
+		r = -ENOMEM;
+		goto kunmap;
+	}
+
 	memcpy(keys_header, keys_header_loaded, keys_header_size);
+kunmap:
 	kunmap_local(keys_header_loaded);
 	arch_kexec_protect_crashkres();
-
-	return 0;
+	return r;
 }
 
 static int restore_dm_crypt_keys_to_thread_keyring(void)
@@ -446,12 +456,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	mutex_lock(&config_keys_subsys.su_mutex);
 	mutex_acquired = true;
 
-	if (key_count <= 0) {
-		kexec_dprintk("No dm-crypt keys\n");
-		return 0;
-	}
-
 	if (!is_dm_key_reused) {
+		if (key_count <= 0) {
+			kexec_dprintk("No dm-crypt keys\n");
+			return 0;
+		}
+
 		r = build_keys_header();
 		if (r)
 			goto out;
@@ -462,7 +472,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	 * cleaned up at the end of kexec_file_load syscall
 	 */
 	kbuf.buffer = keys_header;
-	kbuf.bufsz = get_keys_header_size(key_count);
+	kbuf.bufsz = get_keys_header_size(keys_header->total_keys);
 
 	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
-- 
2.55.0


