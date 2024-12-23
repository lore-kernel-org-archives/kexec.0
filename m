Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C429E77188
	for <kexec@archiver.kernel.org>; Mon, 23 Dec 2024 01:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x0mqPYVSAxy7HB5d7r7C+aXWfY/MM0JGSP7oSkrSPmE=; b=bmwzFanp7hHzquamQb0SBfQPis
	ZT6Pzmg7RwxgeKGOJDmo81Kj6vuvsbZlqlSYDozD6JW4gczuruICAxWpmUjFWb/1mpfg54n1pscGb
	g/NDjwwHcLPE75gSjofwF165yOgOA3gMJz4uenS5/mYcgMEBhXGBRpDdQbCq7YQlues9fWvGjBK4o
	CvW13Z8U4m/Ru/KpvzDlZFBGxtjGSM4G7zP7a2YEdYJAhnFtocTjia2yvExE8IZqV+KGYaNwXChRx
	FHNxs9BVWFlE0CgUiiHEb7cQdOaZ8SnKrxdptJAt4fOizqEVrVPazuOdhXBMKsqJTghRYpGUCAN99
	ZPOSo0+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPXEU-000000094jT-0Dnr;
	Mon, 23 Dec 2024 01:27:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPXEQ-000000094iz-3Atw
	for kexec@lists.infradead.org;
	Mon, 23 Dec 2024 01:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734917257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x0mqPYVSAxy7HB5d7r7C+aXWfY/MM0JGSP7oSkrSPmE=;
	b=TeQQnV7Pf8Ov1XjJOoNFBFOeLPPLiWes9DtqJdgDrEcmkh9lCzFvq+3mrsXWKeyEJNX8EB
	xKnJu43wd7/JcW/WziBfYYYlJ0CcsCverkQGCOXNuLGLBw8sajVXwE1xl5j4PghQU9hsZE
	T6aDUTPYwWtc1TgZ3m5Y4VC1QYtRmKc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-AVCnjdxNNUqss0cB2yjGWg-1; Sun, 22 Dec 2024 20:27:36 -0500
X-MC-Unique: AVCnjdxNNUqss0cB2yjGWg-1
X-Mimecast-MFC-AGG-ID: AVCnjdxNNUqss0cB2yjGWg
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2167141e00eso31002705ad.2
        for <kexec@lists.infradead.org>; Sun, 22 Dec 2024 17:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734917255; x=1735522055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0mqPYVSAxy7HB5d7r7C+aXWfY/MM0JGSP7oSkrSPmE=;
        b=hzyYHCVkHA1bFQSpyfZlEVp3ql5J+Rjghe82sC/sYxvHruavtM34SH+IiKr4+M//MD
         gWi3JwEHKQAEIcQytwURev1yr3ahwwLtudkiygzuxySDum3wHMBExQfk9XhO8s0g4T2c
         jtMccOnHpGo2HIeuFt54ehBKFs2zH8j9KVIrvHrpVouRZUr72/FulegyPrMAi8yri4LG
         wP4cpJUNY7EQxW2OqxSn/sulBZ3hZAsr7P2S708npa8vVZzMVldHIh1oArrKjV2rtcNM
         w9+MlZMb1jYZP7QvKPfad3VhsWxV6PzgN1o0NiRdwuNOgNNIIGWJ9rXvrT5fbmngukXX
         rQRg==
X-Gm-Message-State: AOJu0YwH24kzIxW0OH+myzKzzz6IF9WXvcMDRODYW4nJmC+Q7eQLWNqI
	eZxf+x1Ee058l8IYmJvllbHKO82prQ2YWbhw/L/nMRwX8pbGf8y33WrEpoxj/zEC8XqzjQGQBui
	ek+lMdsDCVGaR3uDUkkBA55P4L6O4OE+khnlUfWKa6df9uVjW92K3VDcAfA==
X-Gm-Gg: ASbGncucxW128gVJbhc6kZY+rEt/xtsUGa5aiWYC4BDY3oaGe5h0W4g4iphx3K8vd3f
	nED5gDxUpWIYT0lpMt4vuE9IfLJg7idUwxch80fIWN7iqW2s2SiohWyR3ftRPiawOWW4oy7v6jw
	cjOe++0D6Qwp5K+2L+H4gWChagscKLYovDJuySmCdjpBz0Vsy9L3w//hZEV5mggHYJ+dHbbtZcW
	1ayywHyE8sA1/Fm9MeLdXg8vJY/z5fD4M1AkSMq5K1Tif2y
X-Received: by 2002:a17:902:d588:b0:216:239e:f90f with SMTP id d9443c01a7336-219e6f2f01dmr193118525ad.37.1734917254795;
        Sun, 22 Dec 2024 17:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7Sy0oRS3iNXNefowlDzzU6P75xzCW7GCOB9v3TsEQTc3tNQKvpRDEVn2dmvlbqtD19moimA==
X-Received: by 2002:a17:902:d588:b0:216:239e:f90f with SMTP id d9443c01a7336-219e6f2f01dmr193118305ad.37.1734917254514;
        Sun, 22 Dec 2024 17:27:34 -0800 (PST)
Received: from localhost ([180.109.216.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962c3dsm62389745ad.31.2024.12.22.17.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 17:27:34 -0800 (PST)
Date: Mon, 23 Dec 2024 09:19:41 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <gqjk6msau5knzo3azmbckastomox3lra4pe6kda4rd7dua53yc@t2zt3mxh5d26>
References: <20241029055223.210039-1-coxu@redhat.com>
 <Z1zsWoRhVaqXkVbb@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Z1zsWoRhVaqXkVbb@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 33X_g0PhePBO4JzQ4EM8m-78BG1_KvWvRMUCotDs39g_1734917255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241222_172738_895233_2E2F6F9D 
X-CRM114-Status: GOOD (  14.56  )
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

On Sat, Dec 14, 2024 at 10:24:26AM +0800, Baoquan He wrote:
>Hi Coiby,

Hi Baoquan,

>
>On 10/29/24 at 01:52pm, Coiby Xu wrote:
>> LUKS is the standard for Linux disk encryption, widely adopted by users,
>> and in some cases, such as Confidential VMs, it is a requirement. With
>> kdump enabled, when the first kernel crashes, the system can boot into
>> the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore)
>> to a specified target. However, there are two challenges when dumping
>> vmcore to a LUKS-encrypted device:
>
>Other than those small concerns, and the lkp reported issue, the overral
>series looks good to me. Thanks for the effort.

Thanks for carefully reviewing the patches and the suggestions to
improve the patch set!

>
>Thanks
>Baoquan
>

-- 
Best regards,
Coiby


