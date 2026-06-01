Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A94CD6E4C
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 05:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N3h3KGyxDslQqLwVRvMFf5xWBl3tL5RQXm1UPbISe7s=; b=0n3ohnOZ9XlkWAm50IsOIUXP4R
	XJSouU5y95+dm5JfGbdEgndZKYm4asGTmrdCADd2wxAU0lUdtWZ9MnoRksThPPX+wniKzAaxcGT2s
	YPKLNGSIVYR545uqZP2vJhsyIjr+MNHeKBfy4pHs15Vlb5Io0G9yhQALfHj9EwUMAffnImOHxVNK9
	7dbNzqomgRF2sw4ayJncE16ZNaUDhO5GLy3mJsAFbqKVt1samPbHMaX33N0MSIU1fBlZ08IzYUNie
	3ZJwv5HbY30mqgp9WkbuWKRHwdEnV4I0NhRnvUpAEFwrfaYqdorKfPhNxQNTFh4l/I/2v3/FB9wJD
	Sz19ufxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTvCI-0000000A9K6-0WUP;
	Mon, 01 Jun 2026 05:28:22 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTvCE-0000000A9Ep-0NFd
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 05:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780291698; x=1811827698;
  h=date:from:to:cc:subject:message-id;
  bh=v37atBlw7bfAZ0isuG5ELB22Mk21Ik6/Vbd/Dy4IC6k=;
  b=Jc3X0g3fpMOhZ2e1lmIC6p6O58yUsfbqNC9HRcOKlGtPo0s0bf9LTqmJ
   cp7YC4+MmsXJFbGwuSiYHHkII8desKLax6FWYbGL9L4iL+rej9aS+AUnT
   QjjFdkyXjWBCpUy7ts0PAbEX8xy01vnlQ4exfY8e2Y4rdMqEwIrbPvLZx
   699JWBDzjXH3TfaI92H8XOYnv9DYhvbAMYbaJ8RPJPMw0/e9cGZp3fMiD
   ujNVOqy2c6W85OqSP+d+s4bYZeEZamEE0g+3FpWMZGv+6btBNzlJkkzvp
   vc18AC2n4vvagQr4BYnRjMh46ux4Fq3JdlrEp6c2ctO5FUGX839mk7oiS
   w==;
X-CSE-ConnectionGUID: xAK7Mf4KTC+pWspH7lAfYw==
X-CSE-MsgGUID: fD4jdDfaT3C3C7xrS8Gk/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80772887"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="80772887"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 22:26:15 -0700
X-CSE-ConnectionGUID: z9Mn5yb7Rwil6BWGgcUlmA==
X-CSE-MsgGUID: bAAmj3eLR6GNhPGqgL6BzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="240953376"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 31 May 2026 22:26:12 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTvAA-00000000AD0-0IRs;
	Mon, 01 Jun 2026 05:26:10 +0000
Date: Mon, 01 Jun 2026 13:25:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Pratyush Yadav (Google)" <pratyush@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next 11/21]
 kernel/liveupdate/luo_session.c:344:48: error: too few arguments provided to
 function-like macro invocation
Message-ID: <202606011344.RHiYuqso-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_222818_171900_69E8B5FA 
X-CRM114-Status: UNSURE (   9.64  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git next
head:   f4b4f5fe58a55a4212a263d9d44416778ca6e7a7
commit: 74cab0be9a5d9d91471c4dee7311dcdfc1c0a6f4 [11/21] liveupdate: validate session type before performing operation
config: x86_64-buildonly-randconfig-003-20260601 (https://download.01.org/0day-ci/archive/20260601/202606011344.RHiYuqso-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260601/202606011344.RHiYuqso-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606011344.RHiYuqso-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/liveupdate/luo_session.c:344:48: error: too few arguments provided to function-like macro invocation
     344 |                  struct liveupdate_session_retrieve_fd, token),
         |                                                              ^
   kernel/liveupdate/luo_session.c:327:9: note: macro 'IOCTL_OP' defined here
     327 | #define IOCTL_OP(_ioctl, _fn, _struct, _last, _type)                           \
         |         ^
>> kernel/liveupdate/luo_session.c:343:2: error: use of undeclared identifier 'IOCTL_OP'
     343 |         IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
         |         ^
>> kernel/liveupdate/luo_session.c:378:6: error: invalid application of 'sizeof' to an incomplete type 'const struct luo_ioctl_op[]'
     378 |             ARRAY_SIZE(luo_session_ioctl_ops)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
   3 errors generated.


vim +344 kernel/liveupdate/luo_session.c

16cec0d265219f Pasha Tatashin          2025-11-25  326  
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  327) #define IOCTL_OP(_ioctl, _fn, _struct, _last, _type)                           \
16cec0d265219f Pasha Tatashin          2025-11-25  328  	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_SESSION_BASE] = {                    \
16cec0d265219f Pasha Tatashin          2025-11-25  329  		.size = sizeof(_struct) +                                      \
16cec0d265219f Pasha Tatashin          2025-11-25  330  			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
16cec0d265219f Pasha Tatashin          2025-11-25  331  					  sizeof(_struct)),                    \
16cec0d265219f Pasha Tatashin          2025-11-25  332  		.min_size = offsetofend(_struct, _last),                       \
16cec0d265219f Pasha Tatashin          2025-11-25  333  		.ioctl_num = _ioctl,                                           \
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  334) 		.type = _type,                                                 \
16cec0d265219f Pasha Tatashin          2025-11-25  335  		.execute = _fn,                                                \
16cec0d265219f Pasha Tatashin          2025-11-25  336  	}
16cec0d265219f Pasha Tatashin          2025-11-25  337  
16cec0d265219f Pasha Tatashin          2025-11-25  338  static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
16cec0d265219f Pasha Tatashin          2025-11-25  339  	IOCTL_OP(LIVEUPDATE_SESSION_FINISH, luo_session_finish,
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  340) 		 struct liveupdate_session_finish, reserved, LUO_IOCTL_INCOMING),
16cec0d265219f Pasha Tatashin          2025-11-25  341  	IOCTL_OP(LIVEUPDATE_SESSION_PRESERVE_FD, luo_session_preserve_fd,
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  342) 		 struct liveupdate_session_preserve_fd, token, LUO_IOCTL_OUTGOING),
16cec0d265219f Pasha Tatashin          2025-11-25 @343  	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
16cec0d265219f Pasha Tatashin          2025-11-25 @344  		 struct liveupdate_session_retrieve_fd, token),
4c08a9f38c50c0 Luca Boccassi           2026-04-29  345  	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  346) 		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
16cec0d265219f Pasha Tatashin          2025-11-25  347  };
16cec0d265219f Pasha Tatashin          2025-11-25  348  
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  349) static bool luo_ioctl_type_valid(struct luo_session *session,
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  350) 				 const struct luo_ioctl_op *op)
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  351) {
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  352) 	switch (op->type) {
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  353) 	case LUO_IOCTL_INCOMING:
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  354) 		/* Retrieved is only set on incoming sessions */
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  355) 		return session->retrieved;
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  356) 	case LUO_IOCTL_OUTGOING:
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  357) 		return !session->retrieved;
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  358) 	case LUO_IOCTL_ALL:
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  359) 		return true;
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  360) 	}
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  361) 
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  362) 	/* Catch-all. */
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  363) 	return false;
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  364) }
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  365) 
16cec0d265219f Pasha Tatashin          2025-11-25  366  static long luo_session_ioctl(struct file *filep, unsigned int cmd,
16cec0d265219f Pasha Tatashin          2025-11-25  367  			      unsigned long arg)
16cec0d265219f Pasha Tatashin          2025-11-25  368  {
16cec0d265219f Pasha Tatashin          2025-11-25  369  	struct luo_session *session = filep->private_data;
16cec0d265219f Pasha Tatashin          2025-11-25  370  	const struct luo_ioctl_op *op;
16cec0d265219f Pasha Tatashin          2025-11-25  371  	struct luo_ucmd ucmd = {};
16cec0d265219f Pasha Tatashin          2025-11-25  372  	union ucmd_buffer buf;
16cec0d265219f Pasha Tatashin          2025-11-25  373  	unsigned int nr;
16cec0d265219f Pasha Tatashin          2025-11-25  374  	int ret;
16cec0d265219f Pasha Tatashin          2025-11-25  375  
16cec0d265219f Pasha Tatashin          2025-11-25  376  	nr = _IOC_NR(cmd);
16cec0d265219f Pasha Tatashin          2025-11-25  377  	if (nr < LIVEUPDATE_CMD_SESSION_BASE || (nr - LIVEUPDATE_CMD_SESSION_BASE) >=
16cec0d265219f Pasha Tatashin          2025-11-25 @378  	    ARRAY_SIZE(luo_session_ioctl_ops)) {
16cec0d265219f Pasha Tatashin          2025-11-25  379  		return -EINVAL;
16cec0d265219f Pasha Tatashin          2025-11-25  380  	}
16cec0d265219f Pasha Tatashin          2025-11-25  381  
16cec0d265219f Pasha Tatashin          2025-11-25  382  	ucmd.ubuffer = (void __user *)arg;
16cec0d265219f Pasha Tatashin          2025-11-25  383  	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
16cec0d265219f Pasha Tatashin          2025-11-25  384  	if (ret)
16cec0d265219f Pasha Tatashin          2025-11-25  385  		return ret;
16cec0d265219f Pasha Tatashin          2025-11-25  386  
16cec0d265219f Pasha Tatashin          2025-11-25  387  	op = &luo_session_ioctl_ops[nr - LIVEUPDATE_CMD_SESSION_BASE];
16cec0d265219f Pasha Tatashin          2025-11-25  388  	if (op->ioctl_num != cmd)
16cec0d265219f Pasha Tatashin          2025-11-25  389  		return -ENOIOCTLCMD;
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  390) 	if (!luo_ioctl_type_valid(session, op))
74cab0be9a5d9d Pratyush Yadav (Google  2026-05-19  391) 		return -EINVAL;
16cec0d265219f Pasha Tatashin          2025-11-25  392  	if (ucmd.user_size < op->min_size)
16cec0d265219f Pasha Tatashin          2025-11-25  393  		return -EINVAL;
16cec0d265219f Pasha Tatashin          2025-11-25  394  
16cec0d265219f Pasha Tatashin          2025-11-25  395  	ucmd.cmd = &buf;
16cec0d265219f Pasha Tatashin          2025-11-25  396  	ret = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
16cec0d265219f Pasha Tatashin          2025-11-25  397  				    ucmd.user_size);
16cec0d265219f Pasha Tatashin          2025-11-25  398  	if (ret)
16cec0d265219f Pasha Tatashin          2025-11-25  399  		return ret;
16cec0d265219f Pasha Tatashin          2025-11-25  400  
16cec0d265219f Pasha Tatashin          2025-11-25  401  	return op->execute(session, &ucmd);
16cec0d265219f Pasha Tatashin          2025-11-25  402  }
16cec0d265219f Pasha Tatashin          2025-11-25  403  

:::::: The code at line 344 was first introduced by commit
:::::: 16cec0d265219f14a7fcebcc43aeb69205adba56 liveupdate: luo_session: add ioctls for file preservation

:::::: TO: Pasha Tatashin <pasha.tatashin@soleen.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

