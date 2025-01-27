Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341A3C02188
	for <kexec@archiver.kernel.org>; Mon, 27 Jan 2025 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=feVXBXQ+By9WArNNSb/bibglGnzo06lZJuKLaLgAuos=; b=lnHUhR/HMkINuy443MU2nrbpAu
	1bkj7lp3b/bacZH3bjlfx7h+pymqWgJmqmjr7IIZTcGi/OWcxl3IB7zKw5L2MrGg47Rd+Ti9cTOnr
	bEQ/UPIpCzQODYnZiBijYnKFRHHTEP17AOgpdItOdhYyWNkGjVdMrFMh3Z6vVMviIGoOtqTcspuEj
	jWEN8dhOeALAJetfKy7rKkacX3paXZvHIMfuwtLHx8OpuVu+pOM7GTljccvHtGbeJooUXRqmAKANh
	0vzqroJGD/9DgdpQRIyaStEnAq9NV2LnSpjSb3ltMQMf9kyDt2eHR20krY1Kapv6418FCunvTMEzI
	geuGIKcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcRfu-00000002j3q-3Pr4;
	Mon, 27 Jan 2025 16:09:22 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcQXA-00000002XWd-24X8;
	Mon, 27 Jan 2025 14:56:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737989776; x=1769525776;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jgZ2GO8S3cXCdWyE6ZvOdFoqm0rhCqZC3ICQKad44uQ=;
  b=AHdTslY5vV6zKb8MKxB27H8Bt4jok9OsA2p9XmnI1YhkdTd2ytSGKdLu
   rtB+yYf2JI2Cf/HREXZZsFOzrFA4de9arZDuV+lsiG3QTugKIzqcN3Pl5
   GZx29PDgQdxZQeKO71Tcrgr9VNrZu/jY1l/PmZRPApngOddXBytwterru
   0SuIUfm2N4K2G2G+y2/qkuc9NsvfhGtE5yyZtZebKBJpCGUanq93BNZ2T
   4P1JABQdENcPVjxa1auws0b4T6ODyc1ALl+pIlVQjvzxPWtBF4ShtkOIc
   JyuNCBiI+CFMDtdtoAnzqiwKvstz8dpN5oOHNLEcYXZHtn4oxPggDHSeO
   g==;
X-CSE-ConnectionGUID: R3UXd7E2QDqYuaf835g+xQ==
X-CSE-MsgGUID: VUQ9L50zQNamNSF0EewFrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="49104685"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="49104685"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 06:56:13 -0800
X-CSE-ConnectionGUID: Z9Coz29cQ6uqfPwc/L4sHg==
X-CSE-MsgGUID: XE2pskZGQO2Q6A9y4rThjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113598177"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 06:56:01 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Joel Granados <joel.granados@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Thomas =?utf-8?Q?Wei=C3=9F?=
 =?utf-8?Q?schuh?=
 <linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-crypto@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-serial@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
 codalist@coda.cs.cmu.edu, linux-mm@kvack.org, linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Song Liu
 <song@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Corey Minyard <cminyard@mvista.com>
Subject: Re: Re: Re: [PATCH v2] treewide: const qualify ctl_tables where
 applicable
In-Reply-To: <f4lfo2fb7ajogucsvisfd5sg2avykavmkizr6ycsllcrco4mo3@qt2zx4zp57zh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
 <Z4+jwDBrZNRgu85S@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <nslqrapp4v3rknjgtfk4cg64ha7rewrrg24aslo2e5jmxfwce5@t4chrpuk632k>
 <CAMj1kXEZPe8zk7s67SADK9wVH3cfBup-sAZSC6_pJyng9QT7aw@mail.gmail.com>
 <f4lfo2fb7ajogucsvisfd5sg2avykavmkizr6ycsllcrco4mo3@qt2zx4zp57zh>
Date: Mon, 27 Jan 2025 16:55:58 +0200
Message-ID: <87jzag9ugx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_065616_543853_20781414 
X-CRM114-Status: GOOD (  29.83  )
X-Mailman-Approved-At: Mon, 27 Jan 2025 08:09:21 -0800
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

On Mon, 27 Jan 2025, Joel Granados <joel.granados@kernel.org> wrote:
> On Wed, Jan 22, 2025 at 01:41:35PM +0100, Ard Biesheuvel wrote:
>> On Wed, 22 Jan 2025 at 13:25, Joel Granados <joel.granados@kernel.org> wrote:
>> >
>> > On Tue, Jan 21, 2025 at 02:40:16PM +0100, Alexander Gordeev wrote:
>> > > On Fri, Jan 10, 2025 at 03:16:08PM +0100, Joel Granados wrote:
>> > >
>> > > Hi Joel,
>> > >
>> > > > Add the const qualifier to all the ctl_tables in the tree except for
>> > > > watchdog_hardlockup_sysctl, memory_allocation_profiling_sysctls,
>> > > > loadpin_sysctl_table and the ones calling register_net_sysctl (./net,
>> > > > drivers/inifiniband dirs). These are special cases as they use a
>> > > > registration function with a non-const qualified ctl_table argument or
>> > > > modify the arrays before passing them on to the registration function.
>> > > >
>> > > > Constifying ctl_table structs will prevent the modification of
>> > > > proc_handler function pointers as the arrays would reside in .rodata.
>> > > > This is made possible after commit 78eb4ea25cd5 ("sysctl: treewide:
>> > > > constify the ctl_table argument of proc_handlers") constified all the
>> > > > proc_handlers.
>> > >
>> > > I could identify at least these occurences in s390 code as well:
>> > Hey Alexander
>> >
>> > Thx for bringing these to my attention. I had completely missed them as
>> > the spatch only deals with ctl_tables outside functions.
>> >
>> > Short answer:
>> > These should not be included in the current patch because they are a
>> > different pattern from how sysctl tables are usually used. So I will not
>> > include them.
>> >
>> > With that said, I think it might be interesting to look closer at them
>> > as they seem to be complicating the proc_handler (I have to look at them
>> > closer).
>> >
>> > I see that they are defining a ctl_table struct within the functions and
>> > just using the data (from the incoming ctl_table) to forward things down
>> > to proc_do{u,}intvec_* functions. This is very odd and I have only seen
>> > it done in order to change the incoming ctl_table (which is not what is
>> > being done here).
>> >
>> > I will take a closer look after the merge window and circle back with
>> > more info. Might take me a while as I'm not very familiar with s390
>> > code; any additional information on why those are being used inside the
>> > functions would be helpfull.
>> >
>> 
>> Using const data on the stack is not as useful, because the stack is
>> always mapped writable.
>> 
>> Global data structures marked 'const' will be moved into an ELF
>> section that is typically mapped read-only in its entirely, and so the
>> data cannot be modified by writing to it directly. No such protection
>> is possible for the stack, and so the constness there is only enforced
>> at compile time.
> I completely agree with you. No reason to use const within those
> functions. But why define those ctl_tables in function to begin with.
> Can't you just use the ones that are defined outside the functions?

You could have static const within functions too. You get the rodata
protection and function local scope, best of both worlds?

BR,
Jani.


-- 
Jani Nikula, Intel

