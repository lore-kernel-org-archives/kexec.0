Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814360A2628
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w8OUNdXb;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=M+MyCXcL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dTOr68dqd9pXsH3sDySoD8YNtJ+vod0XkUHzER129hw=; b=w8OUNdXbswNptKgtdE3/zUb5/e
	OkMMTz7MGmduJgL910LajQSrQlg5PQRwTdSlMr19X/96J1iwLxyvL7ROzsn/4sSxU+OJEC2Hwfh8e
	heacvkyeyJSAsZWDCHHNcanEJ7nGzENyjoBLfSIhisiovi6MgXouI2VGBl4E1UdV4HlYC1pZEBPaS
	fyEm6HszrpUooX7oeODkKnq/Cff2SsnAHW0V2gRchZ1rIneswO5csRHaB8nohaqhIjDFNR3hnmv+6
	0dD75AOT5d5hHUXTfootQi3iVlM+rNN31iHI2Rcs3dxX3V/aie5vv2E12mIxHhpArf0g8GmfmSVtv
	V+vTYPwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR39R-00000005y6N-0PNY;
	Wed, 11 Nov 2026 07:53:49 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR39O-00000005y5A-1RPa
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:53:47 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso19583195e9.2
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794383624; x=1794988424; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dTOr68dqd9pXsH3sDySoD8YNtJ+vod0XkUHzER129hw=;
        b=M+MyCXcLdPn+6ZRIN6Xesl0tQ/w9nr2rrt/OF778Qr1qS7cHiWCFavqePptGo0fsV7
         fVe2vWYaNMUaGSj3/5p1iRNgVmmh1EAvzyJ7SaQ/MkJUQ+Sa7dU/Xnx9a0bozwKrwKrn
         BKLXkKMHeG53PqI8aqPKxWtXLkG9jeQt/X/Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383624; x=1794988424;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dTOr68dqd9pXsH3sDySoD8YNtJ+vod0XkUHzER129hw=;
        b=lqp56ZIz/NfRH3mHKIO5BYRkmRU47BVLe4fmOdaKTfGwJm/HkiYqCVkQ8ajJXrMDDH
         Ekuo9e/S6WphLMh6bY31ErrsCwu/StiAgn8UTv3S99P7U3aNZufWE2+W5y4cRm82AP68
         Ztc7tl7RlYMGHlSlSpQu+D5sugmkz7UOkbDYmFC/LGM3pjEUARi/+uSCoTXk1W+/EUJ+
         zGkXUJcx7CFP7HVg1xax2UKi6Wz8WSsr8+701mgR8XJPI0Xnrx6XkOvZ/Oj/LU+Kjsq/
         yJgEWdaP+Vr4vAqh29fUwOygSMerjOktTgvAF0YzhOuwce8Nb5MqmbrCieBdMTxJazYS
         /UMw==
X-Forwarded-Encrypted: i=1; AL+hErGD2NbNvdGBdYRHwH9q+JGhz0fmOBO4Vjomgja+IkwdXg1vfHrM4vnocbjWv498sXgd3+goNA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/En+xqqJgsd5m4uawIObpZw1WhxqcKsVJWu+kPIlKMVZNOuKMW
	wJHFfHdCdtd+vQ1KoHONst9EkO4Xdm/taPxNyL332mx6LmjeeIYQkc80agRy0hSnRC4=
X-Gm-Gg: AYBFou0Ig9HdKZAbNpN0onzOD+wkTrTZQE8+XNpyRoNiUEMZAaV89D/HPBu5yF0qRvf
	2TgKNDL81G9ADo7E2YKJH9Iaf8VQEieg1mywugtTioYp9Wy+wBUkQEp9c8T3JO5r8pWl7KQkBWM
	OMXVluTn4razlsbRRBcCiOjCHzI1D3WxXvdAPFZVoDAqjbMZK1u5mGXIhB0UoSukGSr/sNV+3EA
	10oFWZaTJ6lnikowCNpgj1jFlZXK7vEaPchpDJgiB+J7XrQWVSQnKHE00V1ErrcDEni7BylIO60
	nILN7noBKMYU7vf3Yc+w/vbyP/09P6tZ09xHWPDHnw1P3guZ5lt4wPPfyR0ofqutMpb7mpd5Wcv
	mQTvdFDIt4sCabnKz8j4ULGlVT2vz39puvzrGAzMXoBdIDQJ9cW7CCC1jpwt8GOW23dYUTziiEp
	aTXRmr2EdDGusOqiKV3F9yBWY4DdC4njcOwXcKWgM0sU9VFK9ckz/HP0t1fGWsmeg7+XCu0X060
	dcWdtMOviJHUVhboiB0DQlz32eUWPp95nAxGtnWRBwfJ7KEePrnC+w7fb0lEKZ7L+Ne63EzdAsy
	emYMTyd6ANTuWHM3EymPLv4MeYLI31bHh6YY8QYsEO/vGgV3haU91SabvltW8SYs/yAIYfc+YWZ
	8FBkWdXPt0Fg+o688Z7REP6dYHFxVuuoM5AdRKGAUmNLxWBm2zEP61UXo+E2Y/E/KyAoC5h+vy0
	t2lDOBBxumDj4vsrl41D3q1CXatdpTHKBLXIgPP7jJZF+sb5l2djSY
X-Received: by 2002:a05:600c:a00d:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4ba093acadfmr26469595e9.34.1794383624548;
        Tue, 10 Nov 2026 23:53:44 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01ff3428sm138135715e9.15.2026.11.10.23.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:53:44 -0800 (PST)
Date: Tue, 10 Nov 2026 23:53:41 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 8/9] liveupdate: Expose the sequence number for consecutive
 live updates
Message-ID: <6f10302874805eccc3960531194c989cdd1588c4.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794383544.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_235346_402111_C9097EB3 
X-CRM114-Status: GOOD (  12.95  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Export LUO's live update sequence number, so that fleet monitoring can
compare hosts on their first live update with hosts that have been
through several.

We want this because some bugs, like memory corruption, may only show up
after several live updates in a row.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/ABI/testing/sysfs-class-misc-liveupdate | 9 +++++++++
 Documentation/userspace-api/liveupdate.rst            | 1 +
 kernel/liveupdate/luo_core.c                          | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-misc-liveupdate b/Documentation/ABI/testing/sysfs-class-misc-liveupdate
index 608f788ef0fa..b0ba0f626793 100644
--- a/Documentation/ABI/testing/sysfs-class-misc-liveupdate
+++ b/Documentation/ABI/testing/sysfs-class-misc-liveupdate
@@ -24,6 +24,15 @@ Description:	read only
 		the underlying KHO handover.
 Users:		system monitoring
 
+What:		/sys/class/misc/liveupdate/incoming/liveupdate_num
+Date:		Nov 2026
+Contact:	kexec@lists.infradead.org
+Description:	read only
+		LUO sequence number passed by the previous kernel. Reads 0
+		if no LUO state was handed over, 1 after the first live
+		update in a sequence, and increments with each update.
+Users:		system monitoring
+
 What:		/sys/class/misc/liveupdate/incoming/sessions
 What:		/sys/class/misc/liveupdate/incoming/files
 Date:		Nov 2026
diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
index 39bbb91d0dd4..61c246371200 100644
--- a/Documentation/userspace-api/liveupdate.rst
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -50,6 +50,7 @@ Monitoring
 
 Read ``/sys/class/misc/liveupdate/incoming/`` to monitor incoming
 sessions and file retrievals without opening ``/dev/liveupdate``.
+``liveupdate_num`` gives the LUO sequence number for the current boot.
 See Documentation/ABI/testing/sysfs-class-misc-liveupdate for the sysfs ABI.
 
 See Also
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index ba174e9aae03..3ca7b3875247 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -441,6 +441,13 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(state);
 
+static ssize_t liveupdate_num_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", luo_global.liveupdate_num);
+}
+static DEVICE_ATTR_RO(liveupdate_num);
+
 #define LUO_INCOMING_ATTR_RO(_name)					\
 static ssize_t _name##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)	\
@@ -458,6 +465,7 @@ LUO_INCOMING_ATTR_RO(files_dropped);
 
 static struct attribute *luo_incoming_attrs[] = {
 	&dev_attr_state.attr,
+	&dev_attr_liveupdate_num.attr,
 	&dev_attr_sessions.attr,
 	&dev_attr_files.attr,
 	&dev_attr_files_retrieved.attr,
-- 
2.54.0


