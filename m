Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFB6CD6E55
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uAqI8V8BwYx0K8lEnRpUN9xzhYsWnniiljD6fuX/n+Q=; b=AW6hosrkvyDvkwJs34si/uRmi0
	MMsVG+FDAhvpiLOJ19Mxfp9fNlEsVn3lRYOcBVPn1ZABgIaeTwjXi0FFfLre8jjB/l5pqyJGu0Ac9
	CMkpGDR9ZLdm7s04LFU9NiWJsECZHsSrqJFsNnL9n9rtdu37iJJg2M3X6jkP0KkkFCLIMtmi4ncIr
	tW905jxlkn5kGJW0ALSrxc7kYOt2uk7vqvu8ExQXZ3cqtNPqQot+UNGU+n7PxJXjNf5WdqcLfgEBF
	bqsvP8w1PltAi0M+KQVFugZlq8kcNJk0Ly48hdffZjOmMzQyR7uErtkHZWLB4dbz4jzrd8PoYSmU2
	2MeyDUTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1Br-0000000Alws-2uP8;
	Mon, 01 Jun 2026 11:52:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1Bq-0000000AlwO-19RA
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 11:52:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 80A476012B;
	Mon,  1 Jun 2026 11:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA361F00893;
	Mon,  1 Jun 2026 11:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780314737;
	bh=uAqI8V8BwYx0K8lEnRpUN9xzhYsWnniiljD6fuX/n+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZkzLhhQNs3Owop3abUEvzsKOXHOg6ohqExZIyUzxQh6gI/qBV42TSp1Di9WYX3dmg
	 LlUq9GDF2b4DW45BnbTqnHj5cMk6XwkZC2uZx1k5/C+CeMOqoTUuIZskHCZSF3zFaA
	 Hrtgf6XhbKjaytGSp+v1ltYsfLKl0ff574i2jdTamJkb5ii3HbijF+KrY6BW0oSsQT
	 zKVOf8lXhCPnC9yocgRx6g/oaIwMay90rlT4gjX/ndBh5LzW0B07oJL/Ikh1aKh5BW
	 /Rgmqrjdg1U6LTRk5kAWI9Bj+S+2wPZm36F7hDadZFff/HxTXskitc6OTwqHkeSXMR
	 vqeieUkSsMZlw==
From: Pratyush Yadav <pratyush@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: "Pratyush Yadav (Google)" <pratyush@kernel.org>,  llvm@lists.linux.dev,
  oe-kbuild-all@lists.linux.dev,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,
  kexec@lists.infradead.org
Subject: Re: [liveupdate:next 11/21] kernel/liveupdate/luo_session.c:344:48:
 error: too few arguments provided to function-like macro invocation
In-Reply-To: <202606011344.RHiYuqso-lkp@intel.com> (kernel test robot's
	message of "Mon, 01 Jun 2026 13:25:29 +0800")
References: <202606011344.RHiYuqso-lkp@intel.com>
Date: Mon, 01 Jun 2026 13:52:14 +0200
Message-ID: <2vxzik82h40h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Jun 01 2026, kernel test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git next
> head:   f4b4f5fe58a55a4212a263d9d44416778ca6e7a7
> commit: 74cab0be9a5d9d91471c4dee7311dcdfc1c0a6f4 [11/21] liveupdate: validate session type before performing operation
> config: x86_64-buildonly-randconfig-003-20260601 (https://download.01.org/0day-ci/archive/20260601/202606011344.RHiYuqso-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260601/202606011344.RHiYuqso-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202606011344.RHiYuqso-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> kernel/liveupdate/luo_session.c:344:48: error: too few arguments provided to function-like macro invocation
>      344 |                  struct liveupdate_session_retrieve_fd, token),
>          |                                                              ^
>    kernel/liveupdate/luo_session.c:327:9: note: macro 'IOCTL_OP' defined here
>      327 | #define IOCTL_OP(_ioctl, _fn, _struct, _last, _type)                           \
>          |         ^
>>> kernel/liveupdate/luo_session.c:343:2: error: use of undeclared identifier 'IOCTL_OP'
>      343 |         IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
>          |         ^
>>> kernel/liveupdate/luo_session.c:378:6: error: invalid application of 'sizeof' to an incomplete type 'const struct luo_ioctl_op[]'
>      378 |             ARRAY_SIZE(luo_session_ioctl_ops)) {
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
>       11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>          |                                ^~~~~
>    3 errors generated.

This happens because the patch got moved from the fixes branch to next,
and next has a new ioctl. Will send a fixup soon.

[...]

-- 
Regards,
Pratyush Yadav

