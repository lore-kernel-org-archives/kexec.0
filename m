Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CA6C77B7F
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 19:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vQkq6NncW3NqfQ56aS03IOAq0MLLE3swC6zHXRkX6lI=; b=smSLJOeroZ3PqS
	OL8+q6rOgnaPAFB8rdtkEYwMGmID2JBJ29EcvWHEKcoUliL5V3zLxw0ykDjKVuD4Wdn2c1MllAiDl
	6+HcDlNeuQe/irxLNC7e5TYNRIGU2x9TS6X1+uWKcbXFEH2K1tKlNFm7DAlzE+gXz7ZKovj/+7gX9
	+nVdZe9ZMD3rzgGvRrd8lgYbZH/cs1LAREx3El6UFphhVrPLkwbRDKMcqETePBg/GDr+EosdW7ZMu
	sOKn4zl+1WWLs8jLWkCDw82wA9PCTQuOfVe51qp3DlsKkpP6oacxC3xAhtV2UCQ6OGl9HR4t+eUZY
	5oI5N1xeDP1jH+FGJu0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxYf8-00Cp7W-2e;
	Fri, 12 May 2023 19:42:46 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxYf5-00Cp6a-26
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 19:42:45 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f4271185daso62124335e9.2
        for <kexec@lists.infradead.org>; Fri, 12 May 2023 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683920559; x=1686512559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DN2lJwVxCSywQ45Toh9NWXRSKQkBQksDIAdmNfkgPbg=;
        b=Pz9gZZLJj0bTpnXxFNomhku198dAZLFRV9cNoX36VzMjl1POqEJjByjCx+TOScAYIb
         3iBkJdxH5ycv111ZXQ9w7h5tkc6P6Ne+UvjU0DctlUE/JiprguiPY3w509PMSPt8tF6z
         ytunHZ+/UlNq4E3rW3AUAMrjsEZKmnMdcB2tP7BxF3dHO0s0MOncGzB6XsKwEB44Cmji
         AbA7RoRaC1NUFSuAs7sWmFnh/TCSXajfjoYgev0bXVcYeVaHxuO8Z1E8aT/caQG42it9
         9xYqhMcpvIdddCJF612T/XiuXecsioCbOv1cG1NVkkUlxpo/Z6UC2sr7Aa0rYOAahIHb
         Y7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920559; x=1686512559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DN2lJwVxCSywQ45Toh9NWXRSKQkBQksDIAdmNfkgPbg=;
        b=GM0CAFCHWz5L4Fid7pfa/jYQc+vORBK7NT/16QIJyrgz/O7HJfLcrUQQt8DWx2OqBO
         KpTZz3nr7knPL/stwMssK1HoZNjJasHegZ/R9X/Qw1zzCzN+8MQSBKge0hnq9AjVWU+X
         rhpsJof6c80CTeLeOrrm7fNKDCTs/KviI7++fqhxXnxLxknT3wSs2XuD2cjkavdLmuii
         T2i/O6dyySMd/DIMPc+HbAlbfm+41AM7zIkdarwlEs7Si6hFoAYVw0mpIJbizoa+29rd
         Qn2el/xp5hgsgRfj/askhsf/AIg6Lvea4NwtRDCF/X1HQLHJo437QUF38eJqJ7i7IyD4
         Sy4w==
X-Gm-Message-State: AC+VfDxoLAk+Aaj3SyNmuW2snjQRySk0RBzMESlBw4LKh+vsE/Qr785e
	cy+QCsVfKJMpNsKqfwFkpcc=
X-Google-Smtp-Source: ACHHUZ7WQC0iGvDme0/M8wQdMxZpP0KeML4RwxJscAaHJ8Z1gcQLji5mEU4q1GgRZuVlj8wSQ4Pbow==
X-Received: by 2002:a05:600c:2210:b0:3f4:2174:b288 with SMTP id z16-20020a05600c221000b003f42174b288mr14545149wml.4.1683920559237;
        Fri, 12 May 2023 12:42:39 -0700 (PDT)
Received: from [10.80.67.26] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4003000000b003063176ef0dsm24256011wrp.97.2023.05.12.12.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 12:42:38 -0700 (PDT)
Message-ID: <4a8f15b7-2897-e7f5-fe7e-fded3a4130c6@gmail.com>
Date: Fri, 12 May 2023 20:42:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-GB
To: Matthew Garrett <mjg59@srcf.ucam.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org,
 dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 James.Bottomley@hansenpartnership.com, luto@amacapital.net,
 nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com, richard@hughsie.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org> <87pm75bs3v.ffs@tglx>
 <20230512161318.GA18400@srcf.ucam.org> <873541bej2.ffs@tglx>
 <20230512191203.GA21013@srcf.ucam.org>
From: Andrew Cooper <andyhhp@gmail.com>
In-Reply-To: <20230512191203.GA21013@srcf.ucam.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_124243_687891_7C02B26E 
X-CRM114-Status: GOOD (  17.93  )
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

On 12/05/2023 8:12 pm, Matthew Garrett wrote:
> On Fri, May 12, 2023 at 08:17:21PM +0200, Thomas Gleixner wrote:
>> On Fri, May 12 2023 at 17:13, Matthew Garrett wrote:
>>> On Fri, May 12, 2023 at 03:24:04PM +0200, Thomas Gleixner wrote:
>>>> On Fri, May 12 2023 at 12:28, Matthew Garrett wrote:
>>>>> Unless we assert that SHA-1 events are unsupported, it seems a bit odd 
>>>>> to force a policy on people who have both banks enabled. People with 
>>>>> mixed fleets are potentially going to be dealing with SHA-1 measurements 
>>>>> for a while yet, and while there's obviously a security benefit in using 
>>>>> SHA-2 instead it'd be irritating to have to maintain two attestation 
>>>>> policies.
>>>> Why?
>>>>
>>>> If you have a mixed fleet then it's not too much asked to provide two
>>>> data sets. On a TPM2 system you can enforce SHA-2 and only fallback to
>>>> SHA-1 on TPM 1.2 hardware. No?
>>> No, beause having TPM2 hardware doesn't guarantee that your firmware 
>>> enables SHA-2 (which also means this is something that could change with 
>>> firmware updates, which means that refusing to support SHA-1 if the 
>>> SHA-2 banks are enabled could result in an entirely different policy 
>>> being required (and plausibly one that isn't implemented in their 
>>> existing tooling)
>> It's not rocket science to have both variants supported in tooling,
>> really.
> People who are currently using tboot are only getting SHA-1, so there's 
> no obvious reason for them to have added support yet. *My* tooling all 
> supports SHA-2 so I'm completely fine here, but either we refuse to 
> support a bunch of hardware or we have to support SHA-1 anyway, and if 
> we have to support it the only reason not to implement it even in the 
> "SHA-2 is supported" case is because we have opinions about how other 
> people implement their security.

The way to deal with this is to merge DRTM support (when it's ready of
course) so people have an option which isn't tboot.

Then warn on finding a TPM2 without SHA-2, and make it a failure for
https://fwupd.github.io/libfwupdplugin/hsi.html#tpm-20-present etc, and
eventually the vendors will decide that the easiest way to avoid getting
a cross in their customers UIs is to implement SHA-2 support properly.

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
