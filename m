Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E46C78820
	for <kexec@archiver.kernel.org>; Fri, 20 Sep 2024 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Subject:To:
	Message-ID:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vW6KhjhCt4jEiZJx61gwzs7apKWofHOw2mXyqbrLqQE=; b=ETdgCG8BRy2zkl
	hwGugTyw5eq/AG0VFP0wypXCHUpiunHc4mbFYsQaMJPmjdaOO+x/Ec+qnYU2dMb4e65IRq50PMTkq
	MlZ1coTpi5JsuCf0dV6Y7SSaTj7DSEKRP8l1LWAIThpZ4y3tBROwJULCeVJFRgYgncISyn4NTirU9
	L/nH080ccSPc+neTneJ2f3EwWvRGEQOGOlhgsx1ptIvktY5mbZtkh8mZWgHzPm4P0GpdKlT9JRiom
	MqJV5yvH+er2+25T4bk0rCz4njSae5+3mFXfTHYvF1v+e+broD13li8zuQvFhYKhB7eQJA27hn441
	PX6hyWzBOoZQzeqMZtMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srbFC-0000000C2Ja-1Buh;
	Fri, 20 Sep 2024 10:52:10 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srbF9-0000000C2JD-3NFM
	for kexec@lists.infradead.org;
	Fri, 20 Sep 2024 10:52:08 +0000
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-7db53a20d1fso1244649a12.0
        for <kexec@lists.infradead.org>; Fri, 20 Sep 2024 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726829526; x=1727434326; darn=lists.infradead.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxitZxgmvoGPY/D0MWsatY/SG1INnyxTi18mvHYSZYE=;
        b=WB4pxVMVy1oPwr5zmLXgaw/7je8w5AYelBUrMrDmXnZTmhv9qwy6JNN2P2tK/zPkVc
         MO/jEdK1w3OqhNnapLh+e+P0i+CuB94jtNspkqVarTlEyV1ai8EAPFJ9qaHdsk+gvbTA
         AZxa82m/4U/H/6CRjr6MwD+HRUom/UbDZKUeq28aQKAEh1iPgKNy0CEafoMLxns3UO5d
         2Ex91K5U/jjI0zYgP0yreq7KqGNuoD7+j7YKt7tkIc0jOPchlFd9lmaNuYXx/iRIh8yv
         EAcmrsYYuLoCfyWcoT2rCH3YRvfRLATxIdq/wk0x8GOrB1PlJYH36vdmOB1xiFjwWfln
         7HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726829526; x=1727434326;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxitZxgmvoGPY/D0MWsatY/SG1INnyxTi18mvHYSZYE=;
        b=DYk3pkj9O+voWF8wuNo3ohjhw2h+H8nOeKePvSoJijUpGabGnmjTjo9FsMstHac6N7
         ZptdTIL6PsZs0QS3l6grQYlHeMzOMlYoYtWOL97T8+AEVRYGiQEBqLbj2EHwCBlqTby3
         su8nXJSMkdbDhuTISKyI8HJXNvSso1eD5XCiXBoc3q6NKzp/NIDZbDQf/N6qx5u5UHMf
         LUK6auRH2cMWT+rQ2lpJu67VrXFZYTWKt2alUAU/H/+GacOdvEljukhDiSTo4zwOElKQ
         UaIZb/8Te6kNRGgb4+tk9dswunvxPGueqORnLY0A4iRPnKJYCxOK/9YUNA4UIiWZs69+
         oAyA==
X-Gm-Message-State: AOJu0Yz9Y7pGD9TneFKJh3ZzD/RBKV9//R05IH9pak7bnqlo6UjmgaP/
	W6xEViOvSJVP0VNurkgzbs7GNAAYptiIVLzX5RJPjC7a+l+LVsLK0FIAyQ+1
X-Google-Smtp-Source: AGHT+IHWnWtpE2I6y0keWG5MzjBuDhF//Wt94HQ3cISfU4803Jdq+4QxFwCzTzUsSaUB5PxjhstS9g==
X-Received: by 2002:a05:6a21:e96:b0:1cf:4d21:f4c1 with SMTP id adf61e73a8af0-1d30c9e9f89mr3157413637.19.1726829526341;
        Fri, 20 Sep 2024 03:52:06 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab5910sm9627527b3a.77.2024.09.20.03.52.05
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2024 03:52:06 -0700 (PDT)
From: Michelle Fangman <dd5797840@gmail.com>
X-Google-Original-From: Michelle Fangman <michfangman@outlook.com>
Message-ID: <726b286039abee39164b3c442734a95348680399633cccf333d8b215ce70a532@mx.google.com>
To: kexec@lists.infradead.org
Subject: Baby Grand Piano  09/20
Date: Fri, 20 Sep 2024 06:52:05 -0400
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240920_035207_847992_6EC4DF2B 
X-CRM114-Status: UNSURE (   3.32  )
X-CRM114-Notice: Please train this message.
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
Reply-To: michfangman@outlook.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello,

I'm offering my late husband's Yamaha Piano to any music enthusiast who may appreciate it. If you or someone you know might be interested in receiving this instrument for free, please feel free to reach out to me.

Warm regards,
Michelle 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
