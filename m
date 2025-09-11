Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B47CAC58E
	for <kexec@archiver.kernel.org>; Thu, 11 Sep 2025 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYWrG/z8ntkohSELJJmfw5BJR4ViX4520Shju2hmuss=; b=mw8m7dWk+eD6iUN/vPwVide/23
	4GmxziQJuKK6go8YYHVmuQQybAm7ejLzijKejL7NP0lXSEP1169IpIseHYemCOBVxCXhP4erRF0hk
	v8YJM+F5rf1PAU1C7iWSdQjG0KI/XP7w6mUamVp/IGFIHsjRtwhf0LMFca9iMdF/wbx37NC4HARv+
	eW78+JVmuMufq8y41IC3xpAQaEoTP4ZPSW+hYuw2iRYLX5ZilUqyKCoRzz8F0SoZgQyyVekbXdBOw
	eicbJF6ecOUQgZTfUsLtrAO9GRO0OhEqpkH4p2dHwjAX7N/EPJjccs4R+ePHgei40AvZvcNn7NNQ4
	/q+im27A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwkmU-00000004NwW-3Jwm;
	Thu, 11 Sep 2025 17:08:22 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwkmR-00000004NvU-3JAx
	for kexec@lists.infradead.org;
	Thu, 11 Sep 2025 17:08:20 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-55f5f7feeddso178840e87.2
        for <kexec@lists.infradead.org>; Thu, 11 Sep 2025 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757610498; x=1758215298; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYWrG/z8ntkohSELJJmfw5BJR4ViX4520Shju2hmuss=;
        b=ZHJuomdnx0nC9/VOKkwjGt5rWAYBUNptjRGZS4NINTc9NjieAWdmaUxNiFldPRv/RD
         BhDul5ISuZ+box0uaoS65nQo2yPM75lXq8nz/twb9pkSxYCIqU/NuKRHNVWBS0BhjyDd
         AmYSEdNKKG2Vmkt+o7y3fcKgp12MvKRm54NYqbJAgMaCOb7x+q9XBsuxXiX4lyih2tzY
         4kP0k29IGG+JCvQSp6bg7p8Azouq5cKMkvGPLPnv+WX4a0O4MrK3+y5g5/L5C6w27D6S
         zdskM4G4Z+k9zTKSMVvO+oy6oICQcCKBVcZvOj0wYPy/LEVoS1iFLav0KgtTo/9SIxV/
         //Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610498; x=1758215298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYWrG/z8ntkohSELJJmfw5BJR4ViX4520Shju2hmuss=;
        b=CnPnBY0/nEklLEh3vuV9yFoHJ6vDx1uh27YT4OnlBJs2BKge2iG/DquTjWpsuuH+Nn
         eb4uUo5JcYZwLBvTdENnlBLIFzCdbP65IUMpHthHgXDxE7q8GXUhaOIbme/8807UcE7b
         QIjZbuwUFXpu9NCtqOFryJ87BQsRH/IgM+lCp66IxPIMvikWjfh1w6bq4yLOO9QArY2a
         vJ+lBs8DIGO8VRuH3Pt7L5EXdGTyrXLgO40b9MnJ9McY9rI4HtzBw5TVc4ZSCHNZkgob
         GDIb/8OdNKkTnvAm6wKFpZ/UEA6ZnPYJyugzcXB/N2g/7xRF+j6U08R6QBcuhNsoejnj
         Zeog==
X-Forwarded-Encrypted: i=1; AJvYcCU7qi8key1QPtcYwqDpoy8VqSyq/H0Y54gD7uQw8pcdhX36/0lmexAcsDaFi9pGdQW1B76tsA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzz7+s92mtJQX83j52lTPBZpdNPIC1AMT8NGAVhaMoNmoNxVE6k
	Q8BKui9C+BDof53CMfye8/BBalYWgBkDAO6Wfcmb4AZo3DPV2wtPsoNf
X-Gm-Gg: ASbGnct3NTro3/8TWDGjNSatoZOj1dtUjmA8HcisF7EYYc7URuVlho4SPreq0TteGQv
	mwaxYA2YdbOtesB072Bul2msp3Tx/qZgcfRK/G5+An5PvSZ82XH2Dx1Le9LBCMc9OIfzg5GW7LM
	NkBz45sIRzDgQVwPsXGgTSBDyM/dMwNI5nxmFFyb+nhswcWlPBjN0LM1l3CPU4DfJl5qYgCnn1U
	TwByHpyRg8UyBvEPJ0N2DVPud65jeUyGsFajiNSEv5/s+vteYtuD3KXVxqAg/DvGhcAPtQGYSgi
	MBMJgZiJ19amK8EjdyLdbTw/hJdm5vEgimxtMqWgCMXXP3rGy0ws962kIr43pMf1jM14fMbz3SI
	hL9/8xTvq0sxIQBnoQ5ngxrqKwbV645XWNloeVH8=
X-Google-Smtp-Source: AGHT+IGkRq1b+XclvjAfbrp2HdIg4dj29v/UCbMXdq6x0LUwuyY9G012qPLCEJ36wPGT4HRWuf5+Cw==
X-Received: by 2002:a05:6512:220f:b0:55f:7066:ce94 with SMTP id 2adb3069b0e04-5704a8b3a0emr33427e87.4.1757610497376;
        Thu, 11 Sep 2025 10:08:17 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65754a7esm516306e87.131.2025.09.11.10.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 10:08:16 -0700 (PDT)
Message-ID: <d74e67e0-2ba7-4af8-a207-132ba634781c@gmail.com>
Date: Thu, 11 Sep 2025 19:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] Documentation, kstate: Add KSTATE documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
 James Gowans <jgowans@amazon.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He
 <bhe@redhat.com>, kexec@lists.infradead.org,
 Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 Ashish.Kalra@amd.com, William Tu <witu@nvidia.com>,
 David Matlack <dmatlack@google.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-8-arbn@yandex-team.com> <aMDMHx1spjeETKK4@archie.me>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <aMDMHx1spjeETKK4@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_100819_852647_C373E481 
X-CRM114-Status: GOOD (  14.73  )
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



On 9/10/25 2:53 AM, Bagas Sanjaya wrote:
> On Tue, Sep 09, 2025 at 10:14:42PM +0200, Andrey Ryabinin wrote:
>> +There are _V forms of many KSTATE_ macros to load fields for version dependent fields, e.g.
> 
> Escape the trailing underscore (i.e. KSTATE\_).
> 
>> +Addition of new field can be done as version dependent field by using _V form of
>> +KSTATE_ macro:
> 
> Ditto.
> 
>> +Subsections
>> +-----------
>> +Another option is adding subsection to kstate_description. A subsection is
>> +additional kstate_description which linked to the main one:
>> +
>> +struct kstate_description test_state_v2 = {
>> +	.name = "test_v2",
>> +	.id = KSTATE_TEST_ID_V2,
>> +	.fields = (const struct kstate_field[]) {
>> +		KSTATE_BASE_TYPE(i, struct kstate_test_data, int),
>> +		KSTATE_END_OF_LIST()
>> +	},
>> +};
>> +
>> +struct kstate_description test_state = {
>> +	......
>> +	.subsections = (const struct kstate_description *[]){
>> +		&test_state_v2,
>> +		NULL
>> +	},
>> +};
> 
> Sphinx errors out on struct snippets like above:
> 
> Documentation/core-api/kstate.rst:17: WARNING: Inline emphasis start-string without end-string. [docutils]
> Documentation/core-api/kstate.rst:17: WARNING: Inline emphasis start-string without end-string. [docutils]
> Documentation/core-api/kstate.rst:21: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> Documentation/core-api/kstate.rst:28: ERROR: Unexpected indentation. [docutils]
> Documentation/core-api/kstate.rst:32: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> Documentation/core-api/kstate.rst:33: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> Documentation/core-api/kstate.rst:84: ERROR: Unexpected indentation. [docutils]
> Documentation/core-api/kstate.rst:100: ERROR: Unexpected indentation. [docutils]
> Documentation/core-api/kstate.rst:102: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> Documentation/core-api/kstate.rst:103: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> Documentation/core-api/kstate.rst:106: CRITICAL: Unexpected section title or transition.
> 
> ...... [docutils]
> 
> reStructuredText markup error!
> 
> I have to wrap them in literal code blocks:
> 

Thanks, I will make sure to check that the documentation builds next time.

