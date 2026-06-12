Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5466DCD98CC
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 03:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xntfuOEIyHmvSchZsW5khUTybYSMKd02TC91c3C8o3U=; b=qJRDyo//FcmBDH9nDaDabvLhQc
	m5wORF/kennL536uR5p+ZIhsh9PFmEmn/hVpP99wKYfXp56jC577+cfMQrNxLUscs273EnVCgvQLa
	Zgqej/y69S/tyGjbxE5nRlt1n99V4z0vsDWIlI7aqIy1jE7CRMZLB/F3XYfvMukGUzeIw0mLy4Js6
	Lu/B3WTgQjTTSLGHyjCSjexZmELTVYPM0fpB59NoJFJkTFXpaex+A0BY9WiVt7suAXHibu0/jSpX/
	WFGeQJ5w46j0m/4yRxEYVLP21UMyGiTHcLrCO52heZCBwVKsY26P/5cTlWxlQ0z2kQhNIeewEjZCV
	puv8Zfog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXsHE-0000000AJK1-2NeH;
	Fri, 12 Jun 2026 03:09:48 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXsHC-0000000AJIa-2Bre
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 03:09:47 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-517de710886so3550691cf.3
        for <kexec@lists.infradead.org>; Thu, 11 Jun 2026 20:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781233785; x=1781838585; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xntfuOEIyHmvSchZsW5khUTybYSMKd02TC91c3C8o3U=;
        b=VEi44FrQbuXjYvd04ek759wG2IpBDwJdxKjI1Q4LralGVGn7EtPB/bJ3IFjDF4mqnx
         OuDC7L7Es2ekvnzFsWm2ynrBCh+niiFeYMyTIgcqkTcBMUnpS7/unVTiLufHhA0M1vXu
         /dVZBWMmjYRSgEISsqTjwraBk4jqXqX4glYX2fsPebxS7lqqOoFNWpgM6Eg66INB+x1S
         glE801imHZVVNP/PJVmJriyArzxJf+N3qQR5z2aCjKy7NVYwRpNgasYqcVZulZZa1pwd
         KvwJUKGWbGqcY7sYokWfaxrNolVAt6rEMCPmVaXztBKpuR8mDbbTRFfcamvitpPPlUbG
         VTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781233785; x=1781838585;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xntfuOEIyHmvSchZsW5khUTybYSMKd02TC91c3C8o3U=;
        b=N69cC62W+1mX5ARRh/rJTWAUgvMsYRiWiK7h+R56k18452iLPPbcvNnX9EXcdEuqUO
         qBTtbnOBNfylEJ2uRztlNGv0XoW2KZiI/zUICle9RPzIAWUisOrvuKRTnsAGPFwwpU6w
         eWuLY7nTOBJCdOTvnYwz2peKoIJijih5dZtf1Iq+BAOMlZXx0RlWP8PbTi+SU6aFNLfR
         AuLk4If24fudRDvkOpOI2uZLJn8+sEXXMwN4o2pXAkz8ylPhsAtI/VY9E3JXV85sYk4z
         TDg3gsEs2PFpWl8VzUdViz9b7aXh0lX7kp0EuYTe2Z4KTYkZC/OwzVIpqQkjhksmk7Wo
         AbLg==
X-Forwarded-Encrypted: i=1; AFNElJ+En5cJmsKPF53lwvtsAZHM91CBCzWFzciqnX43qRLYu4aTe/z7HB6+h4+U+vDwMI80vsYyLw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzUpXbxHL9iUw7GsyInj2siRCXjg6na16Qk3IGq6Bhk97P6DADX
	QnRKRkBhGXrVg1chLrTmnHt+I2WslNufIg4yii0fQgkvUE0Xx64VzJGNb8ROWbsbcvE=
X-Gm-Gg: Acq92OF1jZdURVkPIiLnkNHoEMDeMznXARVjXTHZb9o0LL3edXo7l1OcYkqknrkBLGl
	6U3J7Jb9+dwiR8o+Im1Ff9QEJFDR72Bfg8oxQbLMCg8YXigxTnnvHeI1NSgUrKD51YMcBiYsqMV
	0pPvvAWiNPGm2CMCTip3Ph4RYyuZPIboAcp2CF9yOpth4PeD8U1+eK4i0sbxp6RB09rwbNEUeBy
	cnjrz1P+rFJBINHH48XS3dhpNxaFXZY9rDekyWHVodd7A4xELVs4jdzGrLPB0E/tjvrWkBe6b93
	JzTJ/HU96a2XdpPGAbBrdR/N6i7nAoh1oTHxZq4JkSpfdBzMB5YRbBam+0nsUtb768HKxEGobDf
	njHH96FC7L+CAKY75iJXdx41dUxAXVOAil8Od7Akugx+eI8Qp+eDShKjHr6WeWzFVXx+5rqmMbT
	xiTgu+xXneXMHPcxNfahBrqXwiC6Cj6PRUv0ek2PU2VquZ/bEtwRkU7UE3yIcJ
X-Received: by 2002:a05:622a:4d47:b0:517:6c96:8f1a with SMTP id d75a77b69052e-517fe1aa15emr12844031cf.10.1781233785185;
        Thu, 11 Jun 2026 20:09:45 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301b271e7sm11280296d6.14.2026.06.11.20.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:09:44 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] selftests/liveupdate: Move luo_test_utils.*
 into a reusable library
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, 
 tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
 dmatlack@google.com, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-kselftest@vger.kernel.org
In-Reply-To: <20260610230909.876546-2-vipinsh@google.com>
References: <20260610230909.876546-1-vipinsh@google.com>
 <20260610230909.876546-2-vipinsh@google.com>
Date: Fri, 12 Jun 2026 03:09:32 +0000
Message-Id: <178123377286.908199.18067987861441109485.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2042;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=Q1YkebZUrPZ+GgQoBMbMW+kgGqhbdwwF1mvV7CgUO7E=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqK3h3yfnZ3jsS8JXkMaT63LIpe+05dXcE9vEaB
 MjDN1RDlxiJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCait4dwAKCRC7dyhM23N6
 3hcKEADBF8ES46NdBpAoiyCOsj/C0EyMwZsjl2QYNvWqEoOmvglcXhjyjEA/saicWvmlv2ESKK/
 cEe/l6FNqf+32DnjBDgCWEqDRtecDjgcBAv95FFSYGaMRrWBtrLBiYyOYrTcu1Iyeq/DWG33p6h
 5xcc7eplSuQZDaoUKMlfCVUo1kCppemkkwsEUHE+MoK+ak7tTciqzvhlQTJTkRgg6YTD0JCGz2g
 sWbh72GBFYg3+EIevwvEXJmekqatDlQiJQYxoO8C1TpL1qM5eNudiTdNRx6ccUrNBYWhV4vVeLN
 s0aNyYB0UjuLYNWinZu07/cToXq4Sg2o54HqojGGi5DOvAuZAHVP++KcGuLs4hRox44YPMqn2N5
 yIx9syfnW82SfCFqX6+P5gi4nsvZmmq+mBctMqe3BoDTnpfyOgch276qC6r7AbgKeE+AHv/lAVV
 NlpRJ2bVA9sF5KR1w5+/04jSXVw9INZGW1hQ0nVYTWWas6IR32j08JRWMJfRopCvoiLYqV8NFRZ
 Q44rnvJQOokVauCZmx9cOBA3NjXMl0sL5gS+VHnOD0B68r7rlArCDtEtmfrVZbrYB4Ha0vkStyW
 z84q9G264liybkQgdcVE4SEmggHpMl7psM75p+z2FU3n4qZbF8Eg0WXS0mm4qd0nxq4tOE6YVTB
 2sBcY5z7LmszQrA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_200946_611503_10CA8BF9 
X-CRM114-Status: GOOD (  11.85  )
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

On Wed, 10 Jun 2026 16:09:07 -0700, Vipin Sharma <vipinsh@google.com> wrote:
> diff --git a/tools/testing/selftests/liveupdate/lib/libliveupdate.mk b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
> new file mode 100644
> index 000000000000..0fb738c02330
> --- /dev/null
> +++ b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
> @@ -0,0 +1,20 @@
> [ ... skip 14 lines ... ]
> +	$(Q)mkdir -p $@
> +
> +$(LIBLIVEUPDATE_O): $(LIBLIVEUPDATE_OUTPUT)/%.o : $(LIBLIVEUPDATE_SRCDIR)/%.c | $(LIBLIVEUPDATE_OUTPUT)
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> +
> +EXTRA_CLEAN += $(LIBLIVEUPDATE_OUTPUT)

since this file contains utility functions (luo_open_device, luo_test, 
etc.), naming it liveupdate.c makes it sound like the main 
implementation rather than a test helper library. Using something 
distinct like lu_utils.c would make more sense.

>
> diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
> similarity index 99%
> rename from tools/testing/selftests/liveupdate/luo_test_utils.c
> rename to tools/testing/selftests/liveupdate/lib/liveupdate.c
> index 333a3530051b..897c200f3845 100644
> --- a/tools/testing/selftests/liveupdate/luo_test_utils.c
> +++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
> @@ -22,7 +22,7 @@
>  #include <errno.h>
>  #include <stdarg.h>
>  
> -#include "luo_test_utils.h"
> +#include <libliveupdate.h>

Linux kernel coding style generally prefers block headers to be sorted 
alphabetically.

>
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index 502fb3567e38..6bfd4e53528c 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -25,8 +25,8 @@
>  #include <unistd.h>
>  
>  #include <linux/liveupdate.h>
> +#include <libliveupdate.h>

Please sort alphabetically

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

