Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0304BCD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZqshBP3Sq/jYOyu/A3YXiy/4PR+JxcIb9KcTizCSvhc=; b=p2wKv9slAfi2d1OzKtWJfMCQwW
	qgl393MMX2O6Xa6DNwyGGscxmwgL3wfq3tM6R6G6MBJTaOPgLSDxrY728KTUO2uHxfp/l9sDNdd//
	d4qfrOCZX1RdTCozO8AOVnHBCh20UH8gxg25D7EOWoTV6udzPSDrxr+Ou6NoF+a5BqcezRvVVx6gR
	vEHW03tTXTvpRnq2tiHkspISKR1qxWQtHC9ySPWsO2ojN8pBO3LMqiJaxoWqsm73WEOeQlY1nZZ0d
	10x9PgIJiDVkoZGDcc+4fQ6zcQ9qUnPheD6wJwegL7CDb0KbJHz7OcB2AwposgGTEF2725ioMi9B9
	YhPIZ+yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1Gn-0000000Amg4-3WZK;
	Mon, 01 Jun 2026 11:57:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1Gl-0000000Amf8-1TQI
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 11:57:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 464CF42A93;
	Mon,  1 Jun 2026 11:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E984C1F00893;
	Mon,  1 Jun 2026 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780315042;
	bh=ZqshBP3Sq/jYOyu/A3YXiy/4PR+JxcIb9KcTizCSvhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iIJ8q+0jBaXTH3Rjf0bhlN2blL42ohXlps2PTOj1oV9nD6TwYL38JZ45Yh76+WDkY
	 q2xs0z/kp0DEhmBjmrROvRVYL6ornzYhcBOmmCVzyotlF6x4mrMvaZb3oFQzpvdix3
	 Y+6eFBl2FZ/2OY1u++XGcrkp88JvnJ7UrBW2glmDZZLyJeM0SaYto/LCGiLlhHjodj
	 ouuuMx6+QMC8puKRh4zPFtYUy/vKp+gCXkwSELK9vckK2OXzOB51wbbJNeKWL1Bj8l
	 S0UiQ2dgbJtyMxaSDbi55DLpAunluCl92ncu2LOXB/fOCVQgYesVBqulWvNCALLAX4
	 raeBj+6vTA3Sw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: kernel test robot <lkp@intel.com>,  llvm@lists.linux.dev,
  oe-kbuild-all@lists.linux.dev,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,
  kexec@lists.infradead.org
Subject: Re: [liveupdate:next 11/21] kernel/liveupdate/luo_session.c:344:48:
 error: too few arguments provided to function-like macro invocation
In-Reply-To: <2vxzik82h40h.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	01 Jun 2026 13:52:14 +0200")
References: <202606011344.RHiYuqso-lkp@intel.com>
	<2vxzik82h40h.fsf@kernel.org>
Date: Mon, 01 Jun 2026 13:57:19 +0200
Message-ID: <2vxzcxyah3s0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_045723_434375_288E9C4B 
X-CRM114-Status: GOOD (  12.86  )
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

On Mon, Jun 01 2026, Pratyush Yadav wrote:

> On Mon, Jun 01 2026, kernel test robot wrote:
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git next
>> head:   f4b4f5fe58a55a4212a263d9d44416778ca6e7a7
>> commit: 74cab0be9a5d9d91471c4dee7311dcdfc1c0a6f4 [11/21] liveupdate: validate session type before performing operation
>> config: x86_64-buildonly-randconfig-003-20260601 (https://download.01.org/0day-ci/archive/20260601/202606011344.RHiYuqso-lkp@intel.com/config)
>> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260601/202606011344.RHiYuqso-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202606011344.RHiYuqso-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> kernel/liveupdate/luo_session.c:344:48: error: too few arguments provided to function-like macro invocation
>>      344 |                  struct liveupdate_session_retrieve_fd, token),
>>          |                                                              ^
>>    kernel/liveupdate/luo_session.c:327:9: note: macro 'IOCTL_OP' defined here
>>      327 | #define IOCTL_OP(_ioctl, _fn, _struct, _last, _type)                           \
>>          |         ^
>>>> kernel/liveupdate/luo_session.c:343:2: error: use of undeclared identifier 'IOCTL_OP'
>>      343 |         IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
>>          |         ^
>>>> kernel/liveupdate/luo_session.c:378:6: error: invalid application of 'sizeof' to an incomplete type 'const struct luo_ioctl_op[]'
>>      378 |             ARRAY_SIZE(luo_session_ioctl_ops)) {
>>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
>>       11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>>          |                                ^~~~~
>>    3 errors generated.
>
> This happens because the patch got moved from the fixes branch to next,
> and next has a new ioctl. Will send a fixup soon.

Nevermind. Seems like this is already fixed (thanks to Mike I think?).

-- 
Regards,
Pratyush Yadav

