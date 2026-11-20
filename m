Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C355760A2611
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uD2RN0aq;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fBmjju9Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ka3sdI51heiAiEj1XMuq2JlrX86IIDTRxLvf6oCKKN8=; b=uD2RN0aqY8N/Q/
	y3emZMpTbtDApzSsROiYJWG1iBTLd0KsbeFdVNkdDc6N5oRWH/zdDIyiGdk38ixavPctoVV9AAYlF
	5qUuBxKsDdlflTzMrllAYhZgFSOH1rDvvveihAx5S7y6svZJBk7K92FQJvka/pFgSIjE35RSw695E
	Pj9XsS98DXc3EG7rWNsS3Mk6s3ZUojnYxqf0RJIR5ZveM7CN9eRlO8j9cR5nmWrhICfSXh+Tdj1hK
	ZEQYFPBWAB2XKFZ/sE/xadOa6vlOJHq9adE0M4t2KZ5CFHmMuIZHbCaiYixobyt9NrWhbzrvJwVh4
	fzX6x19KzbrGn8jMbMpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUIz-0000000G5p4-1NYZ;
	Fri, 20 Nov 2026 19:29:53 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUIt-0000000G5nT-0drG
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 19:29:51 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2f02f04a426so10775165ad.1
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 11:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795202986; x=1795807786; darn=lists.infradead.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ka3sdI51heiAiEj1XMuq2JlrX86IIDTRxLvf6oCKKN8=;
        b=fBmjju9Qq8pkP+QC34Xuje8Ll9C7dV70vfHlfp0zsSMP+AvpC4WxkUIBksMx8E9/qZ
         7k/YCtfG1O/snwJJBEAZojyuERAeZHs7vFZ+ibPSv//eH3nUis1jQqJMaMlnJ7qF+s24
         xJOI8fFzdcuTnXskXKu3b7Ap2TzT0xYxqpJXvEnxTqMKXrnS+KvJ/XXCQpUvTP4Ry6MX
         VYFLZ4T03Mn/xh2PsygNAXJNA2neQ36MineKZC/RP7gBGDUMnlVffhoA5NOhi9arosKq
         b5XqyeB+/4PbL6H2eZn5USqWM86oRjKqG1fNuKEC1V4XLrj7inPl0V/nZ6hw2PkjZ5Qh
         7j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202986; x=1795807786;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ka3sdI51heiAiEj1XMuq2JlrX86IIDTRxLvf6oCKKN8=;
        b=ovyZKrVpwo+ZH80lGNiC53KxhBpbd5OtvxgNLr/Jv61B9b+IK6rbVQgWzyWVsa5C8Z
         eGEGZ3HWs6zcXxkHVON7Aa3ogN11p7BpHnPqFS0s4JQXG74s1qlkEea/INQ12mZHG+il
         uWguJE2FVqVP7yBLYt7jv6VUbpXA27of4hyYpXNyOG/d0L39iGU1fsNiX/D1gOeGifXz
         QPiUN0mbkll8vF/IK9+XhQCArFBNB03tai4hzS9w1ppDaNuQNaV1m/Grf5C/FmHfZEJO
         qLYSIddmw7eMp/EKfATXrn/V+C3TK3xW/L9aGA1QSZ7bMIR2rXLxHQTooJYhmcga5spu
         5fIQ==
X-Gm-Message-State: APuU4Z/It+KtqLsvuhumUAp4O0zzuUxXpcPMQC6XiXELTcJwf73XpGkZ
	uAA80uNUIWYI8PL+XEP/s0yUfNV9DgmJdzczqTacPic0s0tNnI2Nyh638ronIZ9oaA==
X-Gm-Gg: AZFdTZcdXaExaonnIyJmV4wRVMRdqizI6GPJ+0+mzB10LMptgJhH3rhFe0tENG5U4AR
	JinKtwBsvlO9ip41DNevho1QTa+d+Uc5Oe814ziA8otFzVbSb5a+fgQVFyvwtlCLrjk3ozqrIFn
	3aATD1F/kTzDOhukv5KR+QuqZ3Pv6BBCUFblIGplv8dsum4dQYDZlrhXwjUQLlijEy9VtbTNus6
	ei72HaBpiI85iXyKDtBHi7cFoIvpHD/71FxjXo47L5eNVnsdVub0S36GGKJ7tXpjHM62AqsI2/y
	9BBMZTtEs54hyJjRIH8RmRsjjTUSyahjf5uN/AdTgZ4qLBPkCj9tu4UQC8SM3k8JLEmvKyoHAQc
	6CWpPIUU2MQyiOOf9CZnjDA/DSQ2g+ZM/+2rRduu1imfvHFtWZT57sT+tEBwo6nufn1/TQSDWPu
	cbUJ+4+uLmb5tCSgFl0sXNjB4rbFciitTqBlIQLqzRpEhPLq3LruSVLm0kgtSUrqDBqq/JBpvIh
	nogdgm77g5LciyORyEi/yLlVlQLzQcRuT5b+Twr/sHWX4KFKS4HxyAt9dIta49+yD4a89DqOcsC
	SQe6KZOrmfhCXJEDQrrTW6ZA8JHhVIGXAkOhLswK3DNZMy0gvaW0CtaCDClVc9H0
X-Received: by 2002:a17:902:ef49:b0:2ea:192a:13b8 with SMTP id d9443c01a7336-2f03f1cfb70mr39502795ad.20.1795202985149;
        Fri, 20 Nov 2026 11:29:45 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2ad2sm18293005ad.16.2026.11.20.11.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:29:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 11:29:42 -0800
Message-Id: <DN0ACH1KR5BS.A33KFC1ZMPTZ@google.com>
To: "Pranjal Shrivastava" <praan@google.com>, "David Matlack"
 <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson"
 <alex.williamson@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Down" <chris@chrisdown.name>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Vipin Sharma"
 <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi Liu"
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
From: "David Matlack" <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-10-dmatlack@google.com>
 <awBkg0ODE436CZy0@google.com>
In-Reply-To: <awBkg0ODE436CZy0@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_112949_701050_C8C38DB3 
X-CRM114-Status: GOOD (  32.18  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 20, 2026 at 7:17 AM PST, Pranjal Shrivastava wrote:
> On Wed, Nov 18, 2026 at 10:37:00PM +0000, David Matlack wrote:
>> Adopt Access Control Services (ACS) controls on all incoming preserved
>> devices (endpoints and upstream bridges) during a Live Update.
>>=20
>> Adopting ACS controls avoids changing routing rules while memory
>> transactions are in flight from preserved devices. It also keeps IOMMU
>> groups from changing during or after Live Update.
>>=20
>> The adopted controls are recorded by the pci_save_state() call in
>> pci_bus_add_device(), which runs before drivers bind, so they are
>> reapplied by pci_restore_state() if the device is reset. Allocate the
>> ACS save buffer for incoming preserved devices even if they match a
>> device-specific ACS quirk, since their adopted controls live in the ACS
>> capability, and panic if it could not be allocated.
>>=20
>> To simplify ACS adoption, reject preserving any devices that require
>> quirks to enable ACS as those quirks would also have to take Live Update
>> into account. If such a quirk matches an incoming preserved device
>> anyway, e.g. because it was added in the new kernel, log a warning and
>> adopt the device's ACS controls regardless, rather than reprogram a
>> device in the path of a preserved device's memory transactions.
>>=20
>> Signed-off-by: David Matlack <dmatlack@google.com>
>> ---
>>  drivers/pci/liveupdate.c | 75 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/liveupdate.h | 16 +++++++++
>>  drivers/pci/pci.c        | 13 +++++--
>>  3 files changed, 102 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>> index 00d6fa5236e9..b99a88c2c199 100644
>> --- a/drivers/pci/liveupdate.c
>> +++ b/drivers/pci/liveupdate.c
>> @@ -123,6 +123,9 @@
>>   *
>>   *  * The device cannot be a Virtual Function (VF).
>>   *
>> + *  * The device cannot require device-specific quirks to enable Access
>> + *    Control Services (ACS).
>> + *=20
>
> [...]
>
>> +#include "liveupdate.h"
>>  #include "pci.h"
>> =20
>>  DEFINE_MUTEX(pci_slot_mutex);
>> @@ -1071,9 +1073,13 @@ static void pci_allocate_acs_save_buffer(struct p=
ci_dev *dev)
>>  	/*
>>  	 * Devices that rely on device-specific quirks to enable an ACS
>>  	 * equivalent keep that configuration outside of the ACS Control
>> -	 * register, so they are configured from scratch on restore.
>> +	 * register, so they are configured from scratch on restore. The
>> +	 * exception is devices preserved across a Live Update, which always
>> +	 * adopt the ACS controls established by the previous kernel and need
>> +	 * the buffer to keep them across resets.
>>  	 */
>> -	if (pci_need_dev_specific_enable_acs(dev))
>> +	if (pci_need_dev_specific_enable_acs(dev) &&
>> +	    !pci_liveupdate_was_incoming(dev))
>>  		return;
>> =20
>
> The ACS save buffer is forced for incoming devices that match an
> enable_acs quirk, but neither existing quirk keeps its controls where
> the generic code saves them (Intel PCH Root Ports have no ACS cap,=20
> SPT/UPT has the Control register at +8, not +6). Is the intent that=20
> such devices just lose their adopted controls if they ever lose config
> state later? (e.g. a Root Port D3 cycle after pci_liveupdate_finish())
> If so, maybe worth calling it out in a comment?

The previous kernel refuses to preserve any device that requires a
device-specific quirk to enable ACS, and every kernel that supports
preserving PCI devices already has the PCH and SPT/UPT quirks. So
neither of those quirks can match a device that was preserved by the
previous kernel.

A quirk can only match an incoming preserved device if it is new in the
current kernel (or the previous kernel was built without
CONFIG_PCI_QUIRKS). In that case the previous kernel did not apply the
quirk and programmed the device's standard ACS Control register, which
is what the save buffer captures. So the device just continues with its
non-quirked ACS configuration from the previous kernel.

I will expand the comment and the changelog in v12 to make that clearer:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b5b578355a1b..f3d58b5e7a5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1073,10 +1073,14 @@ static void pci_allocate_acs_save_buffer(struct pci=
_dev *dev)
 	/*
 	 * Devices that rely on device-specific quirks to enable an ACS
 	 * equivalent keep that configuration outside of the ACS Control
-	 * register, so they are configured from scratch on restore. The
-	 * exception is devices preserved across a Live Update, which always
-	 * adopt the ACS controls established by the previous kernel and need
-	 * the buffer to keep them across resets.
+	 * register, so they are configured from scratch on restore.
+	 *
+	 * The exception is devices preserved across a Live Update. The
+	 * previous kernel refuses to preserve devices that need such a quirk,
+	 * so a quirk can only match here if the previous kernel did not apply
+	 * it (e.g. the quirk is new in this kernel). The previous kernel then
+	 * programmed the standard ACS Control register, so save it to keep
+	 * the adopted controls across resets.
 	 */
 	if (pci_need_dev_specific_enable_acs(dev) &&
 	    !pci_liveupdate_was_incoming(dev))

>
> Apart from that:
>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
>
> Thanks,
> Praan

Thanks for the review!

