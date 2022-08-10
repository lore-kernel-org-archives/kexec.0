Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10C6C00140
	for <kexec@archiver.kernel.org>; Wed, 10 Aug 2022 22:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=t2COo/ehhp0bwwBUp/3jI2gKWPYSyYg8UpFNX+j8nmg=; b=e3ldqs+GV4NOdH/+8vColSzuNW
	J+yWSfuV9k9mq4RyCaFVcnkIU8CXGhW0eoFjVzINoV37JsgGs9owoRdAPKsRw6RxKXUaw+cMy0vQL
	tUacTvunIvkos7cOcBsXDf0uqLQa4vvPcN2j7U0Y1NHM173qQtkQf8X/eonDpzatLHXfzpieMwa/A
	DXj0M4voFwFyZ5VE/VBhHVqkb1u8uOQEjLkf6BRiCqcGURvNUe3lMrcVl/0V6t2vNi75FRfpmg3QC
	KHKoKh11tRExiB/urPnGfX4kNlM3pRTHEuk7Tw+/NCqKmcRpXouSra8jO8PwXevY4SKZxTeuzZ1vj
	WIGACKZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLuPp-00G3fk-9V; Wed, 10 Aug 2022 22:43:05 +0000
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLuPk-00G3ZQ-TK
	for kexec@lists.infradead.org; Wed, 10 Aug 2022 22:43:03 +0000
Received: by mail-vs1-xe2c.google.com with SMTP id 129so16646487vsq.8
        for <kexec@lists.infradead.org>; Wed, 10 Aug 2022 15:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=L4ZmggSO9xHQTCWry0uFo08uI+EmJkg/0BB5nnCkh3Y=;
        b=aX9pLcIEAc1nli+FHFsC5tPwZPjklSSZmircj44vG203GOZKv6+Y+XxZcy0Bu+lZM6
         Qox4k8oEApJMkelWTdJjQvsvvyuZ7ixCy6z+YOE4mQoAOHKvqNmDcFuwWfyTYuYKCmG2
         SY7S8hSkpGUK0S1ZVA/79OiUdS4laBaSJ54+L9cTEcA44bJFrY83B1kZ0AU0VokcLNAJ
         aguYALmo0I+JyG2PTLiO+QBAtw40fSX14crH3NNmbR0NhKDj3+Ojxoju2oOyIZoy/rZ2
         y3C0Ddt2uH+VDHglR9oypvbQrgT2OkPlw191qeYKJenp8bKeEzIfXJPQkq8cn3wKwvSr
         ypEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=L4ZmggSO9xHQTCWry0uFo08uI+EmJkg/0BB5nnCkh3Y=;
        b=llXzUbg7jHeCYKkOQwI9o0Gp3DDwZiZ93CbLpLHgQRiXbMKDZLEC7AxlBBAFm2x4Af
         jVTl5dO7snWCZsLZBOZsW+7hZOLWH90iqD29C/K8g4zkDigJsjwdH2oDPI0PQuCf2+Hr
         4XKrl9rTetHjE4G3sqMljemBwo0sidXKsqgUHjRyIgwlVKW/2MHa7tMUE4oPQH3wCueg
         FAki06CwveUyBXp3tUJ5Wwo7bs38KxL6YJXtwWEcGtmdvJjUf4EidBRn/Ec6ctnM+i+l
         sRp2Z2T7pP6PpPp6EFJriCAUfoNUsU70EmWcITOOn7tegUw5b2UqXzAsWoclLPpoR2up
         GGRg==
X-Gm-Message-State: ACgBeo0/utC5cZphnWLCUqYihFOr0KK90NJH5ITdJ9TJ4mtXX+XZU5IO
	0D8bPl8p79lgjZus/yMVdY/BMzs3PP0U4KwVSr268UE055XGaA==
X-Google-Smtp-Source: AA6agR7J4bZ19mEDkEkoHie80VQ/whHmbVQMk6vfdIOdX4uLuq+CAgWZvOqYt0ajmLhcLffAFqv2ZXZCcfhyjf95RWE=
X-Received: by 2002:a67:de84:0:b0:385:5a6b:15ae with SMTP id
 r4-20020a67de84000000b003855a6b15aemr12843253vsk.2.1660171376692; Wed, 10 Aug
 2022 15:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAKE-ki_vO=2SXGsX8cjX+89MP09Tku4KyNANPTiEPKUx7y-LpA@mail.gmail.com>
In-Reply-To: <CAKE-ki_vO=2SXGsX8cjX+89MP09Tku4KyNANPTiEPKUx7y-LpA@mail.gmail.com>
From: Donny Xia <donnyxia@google.com>
Date: Wed, 10 Aug 2022 15:42:45 -0700
Message-ID: <CAKE-ki_LDGQDdMJ5MFcw-C83CPVPd98XRY1u-vwGvLbCW0j_+Q@mail.gmail.com>
Subject: Fwd: Question about the size of VMCOREINFO
To: kexec@lists.infradead.org
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_154301_008480_D02FE19B 
X-CRM114-Status: GOOD (  10.04  )
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

HTML email was blocked. Forward to the email list.


---------- Forwarded message ---------
From: Donny Xia <donnyxia@google.com>
Date: Wed, Aug 10, 2022 at 3:39 PM
Subject: Question about the size of VMCOREINFO
To: <dyoung@redhat.com>
Cc: <bhe@redhat.com>, <vgoyal@redhat.com>, <kexec@lists.infradead.org>


Hello Kdump Maintainers,

We utilize the kexec and kdump feature heavily to collect the crash
dump file when the kernel crashes. We write some customized values
into VMCOREINFO and we find that eventually the size of the data we
write exceeds the size of VMCOREINFO. I find that the size of
VMCOREINFO is one page, which I believe is 4k. I am wondering is there
any specific reason to choose this size? Is it possible to use a
bigger number? Any suggestions about it would be appreciated.

Thanks.

Regards,
Donny Xia

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
