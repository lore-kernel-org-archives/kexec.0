Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0CBCCD19F
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mQnZEYCV9bKld5b50ctQ+pM6UruS6J9Khe0B9TcKg+0=; b=3GvhvRghLhgQsL6yRqNsSvEt2Z
	wAXQaiLUNpwxQQ+yUrhSlDZtTV+pvYkxJcYbFTlH3fZhlmm151nH9oOpDbI8H4goktYNbI7plRVzv
	pyTG4RMmSI8WcfjPRHZxyWRRjSmWa4RvDvyXX95+9eLakN3uIa//Fidj1wLaIx912NbwcDXyhdPQ8
	qdDZH1HJMENYxLrwGKlsd4GMXAQtZT2N56OleTj8ytpcOLWOCqDTU/fAkwglvy2nEJ9HMIltIUh6U
	2wzQaAIi9AZVvunvReh4ebfeSXhXY7/NIZwpWxdHgh5zlNtPyaNDxCwrP4U8Z/HbixH0fBCpuDTKC
	Ri0nb31Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyJ1-0000000FAwY-0qq5;
	Mon, 20 Oct 2025 22:24:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIz-0000000FAvL-023A
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQnZEYCV9bKld5b50ctQ+pM6UruS6J9Khe0B9TcKg+0=;
	b=A3ODtZ0zZ7g1Av+1kuoPlrTQbFI60PZ677Ls850gvME5Bf+lbr/cDC+y4ha5tHnNNoUySf
	sNxxeCzu8qDZXQSdsXM4N+IRxMcGX6kYJbp2zXpkGZdTZTFTPLoXABB0a231vJA7wGXw+P
	B6HJJDNeMYPijG8oEGjJDuYT4dIj43M=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-F0JXBSZRPvmYUsAjls0HVA-1; Mon, 20 Oct 2025 18:24:38 -0400
X-MC-Unique: F0JXBSZRPvmYUsAjls0HVA-1
X-Mimecast-MFC-AGG-ID: F0JXBSZRPvmYUsAjls0HVA_1760999077
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so4050941a12.1
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999077; x=1761603877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQnZEYCV9bKld5b50ctQ+pM6UruS6J9Khe0B9TcKg+0=;
        b=MB9MIHOgOfWbTyvVXl2tg3xjB6wXPv2pgfnRdBPzYUh/BQrexxHPlHeOSi5+nVlDY/
         qR8DSrsY5apQTcgeKN+EqCHDYuWt8NRYFPJXaFHDadS6V0PUQ5l8NyNWv2TvYBtzNZHV
         E+Ku8NZgS/HR4Wec8roZizUb6YL5MIGYLHMYIDPHtww/RHAnXS/WFRUHgByM3vT/Uov5
         2Pn8FjTTirARSth1nxUifGZcJ5chPDTp23g/8etTraiehBbZofs9BwsKm2w4tNwthEc5
         9Y6idLSj4xwurvtU3GFtd9IqKWLWMOuw++jepSxGzSuKir49D01iMojj073Umj5au/QU
         XEug==
X-Forwarded-Encrypted: i=1; AJvYcCUT25Mews9eXOJufmGjZ/md+pxwx8oROLOxCHqolf8uKPbN+m2tr+PBZJvXW+wjbSoeBEirrw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyTXkZ9oEUY2k7Sq/kzwN+mQsm4dPrBS7nNG4WRktz+6qsd4LXP
	pyf3lXY7451y7A1hyaodiPq2NZqnuyrzIVK8k5g3VZ1pxj5WEGnDYhdNLtLVxtmdVrJmYHtoI1j
	xTebfrts9/kaHo7LZ91thLa3RLnY6Q4P04ZM0jjnTXUpJXpvc8zOnb3GYqiHC28FHrjcvlg==
X-Gm-Gg: ASbGncvT7/8vP7m1FcISUPMhmzckVivd38kjuqZKqYuJonn4qsB56Ge7nQn5TUNFr07
	7mUNQwe/3pIBZGOdlg7Gll+warhp40J3TpN3Vwd+h2HEeJ0Emv3mbjqniIIyEZYi+Vv1mBbeMCz
	lEq/mcE1SkkxMF+M+yWu2vbp2i+C/+gyPh6aEe2d07Dseklc6SOsU1jh8BAi0yvBklfJSDeXqtn
	iv3w4icO4G4gpAIfsMPoV37IJAWkJaQStdP4SVcxj6S7deHBQ6JJdEfKhVHbNwcjYS4Mg81QS33
	EyEF3HAc06Tw0zRf3FgqOok2UgAwqYGB7z5fUG/kppwPAzsUkNfHlbLYHUC1a5rfoDUrKprAzJY
	wJcuXZCcmDthB7Mox3xh0MYFI1uJ9DAlmWHy6i1rpTvw=
X-Received: by 2002:a05:6a20:5483:b0:334:93f3:9b28 with SMTP id adf61e73a8af0-334a8644249mr18600021637.56.1760999077051;
        Mon, 20 Oct 2025 15:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSKZ4X1jpoykiVjNKJiDhijpwsO0ZuGYRqjNW697eZxHisQE4QlsdDxBioyyM2mkqfV8bC4g==
X-Received: by 2002:a05:6a20:5483:b0:334:93f3:9b28 with SMTP id adf61e73a8af0-334a8644249mr18600001637.56.1760999076645;
        Mon, 20 Oct 2025 15:24:36 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:36 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 05/14] eppic dwarf: support anonymous structs member resolving
Date: Tue, 21 Oct 2025 11:24:01 +1300
Message-ID: <20251020222410.8235-6-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MbC0A0NsZx-CFFxhHm8FTrcm77Azh3a1j9VUSglZU0U_1760999077
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152441_121696_0E181E82 
X-CRM114-Status: GOOD (  17.32  )
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

Previously, apimember cannot dive into members which belongs to anonymous
structs. E.g. mm_struct has structure as follows:

0x000027bc:   DW_TAG_structure_type
                DW_AT_name      ("mm_struct")
0x000027cb:     DW_TAG_member
                  DW_AT_type    (0x00008dde "structure ")
0x000027d2:     DW_TAG_member
                  DW_AT_name    ("cpu_bitmap")

0x00008dde:   DW_TAG_structure_type
0x00008deb:     DW_TAG_member
                  DW_AT_type    (0x00008d8e "structure ")
0x00008df2:     DW_TAG_member
                  DW_AT_name    ("mm_mt")
0x00008e00:     DW_TAG_member
                  DW_AT_name    ("mmap_base")
0x00008e0e:     DW_TAG_member
                  DW_AT_name    ("mmap_legacy_base")

GET_DIE_NFIELDS_ALL() for mm_struct will only iterate 2 members, it will
not dive into the anonymous structure and iterate members as mm_mt,
mmap_base etc. In other words, there is no way to reference members as
mm_struct.mm_mt.

This patch will make apimember recursive, when anonymous struct/union found,
it will dive deeper to discover further members to make mm_struct.mm_mt
reference possible.

E.g for the following eppic program:
    int main()
    {
	    struct mm_struct *m = (struct mm_struct *)0xffff96b7d1afa680;
	    printf("%lx\n", &m->mm_mt);
	    return 0;
    }

Before the patch:
    File /tmp/test.c, line 4, Error: Unknown member name [mm_mt]

After the patch:
    ffff96b7d1afa6c0
---
 extension_eppic.c | 73 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/extension_eppic.c b/extension_eppic.c
index c4a13b9..ebace25 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -223,13 +223,16 @@ out:
  * Get the type, size and position information for a member of a structure.
  */
 static char *
-apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
+apimember_internal(char *mname, ull idx, type_t *tm, member_t *m,
+		long offset_base, ull *target_index, ull *global_index)
 {
-	int index, nfields = -1, size;
+	int index = 0, nfields = -1, size;
 	int nbits = 0, fbits = 0;
 	long offset;
 	unsigned long long m_die, die_off = idx;
-	char *name = NULL;
+	int type_flag;
+	unsigned long long t_die_off;
+	char *name;
 
 	nfields = GET_DIE_NFIELDS_ALL(die_off);
 	/*
@@ -239,43 +242,61 @@ apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
 	if (nfields <= 0)
 		return NULL;
 
-	/* if we're being asked the next member in a getfirst/getnext
-	 * sequence
-	 */
-	if (mname && !mname[0] && last_index && (*last_index))
-		index = *last_index;
-	else
-		index = 0;
-
 	while (index < nfields) {
+		name = NULL;
 		size = GET_DIE_MEMBER_ALL(die_off, index, &offset, &name,
 					&nbits, &fbits, &m_die);
 
 		if (size < 0)
 			return NULL;
 
-		if (!mname || !mname[0] || !strcmp(mname, name)) {
-			eppic_member_ssize(m, size);
-			if (name) {
-				eppic_member_sname(m, name);
-				/*
-				 * Free the memory allocated by makedumpfile.
-				 */
-				free(name);
+		if (!name && GET_DIE_ATTR_TYPE(m_die, &type_flag, &t_die_off)) {
+			char *ret;
+			ret = apimember_internal(mname, t_die_off, tm, m,
+						offset_base + offset, target_index, global_index);
+			if (ret)
+				return ret;
+			else {
+				index++;
+				continue;
 			}
-			else
-				eppic_member_sname(m, "");
-			eppic_member_soffset(m, offset);
-			eppic_member_snbits(m, nbits);
-			eppic_member_sfbit(m, fbits);
-			*last_index = index + 1;
-			return drilldown(m_die, tm);
+		}
+
+		if (*target_index == *global_index) {
+			if (!mname || !mname[0] || !strcmp(mname, name)) {
+				eppic_member_ssize(m, size);
+				if (name) {
+					eppic_member_sname(m, name);
+					/*
+					* Free the memory allocated by makedumpfile.
+					*/
+					free(name);
+				}
+				else
+					eppic_member_sname(m, "");
+				eppic_member_soffset(m, offset + offset_base);
+				eppic_member_snbits(m, nbits);
+				eppic_member_sfbit(m, fbits);
+				return drilldown(m_die, tm);
+			} else
+				return eppic_strdup("");
 		}
 		index++;
+		(*global_index)++;
 	}
 	return NULL;
 }
 
+static char *
+apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *target_index)
+{
+	char *ret;
+	ull global_index = 0;
+	ret = apimember_internal(mname, idx, tm, m, 0, target_index, &global_index);
+	(*target_index)++;
+	return ret;
+}
+
 static int
 apigetctype(int ctype, char *name, type_t *tout)
 {
-- 
2.47.0


