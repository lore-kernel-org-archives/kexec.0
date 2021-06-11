Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410044.outbound.protection.outlook.com
 ([40.107.141.44] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrd8S-004S42-Bj
 for kexec@lists.infradead.org; Fri, 11 Jun 2021 09:07:31 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: Re: Compiling makedumpfile from source
Date: Fri, 11 Jun 2021 09:07:24 +0000
Message-ID: <TYYPR01MB67770864ECE9A641AE5BDAA9DD349@TYYPR01MB6777.jpnprd01.prod.outlook.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: manty kuma <mantykuma@gmail.com>
Cc: kexec-ml <kexec@lists.infradead.org>

-----Original Message-----
> When i try to makedumpfile without vmcorefile, it complains that
> "/tmp/vmcoreinfo no such file or directory" and fails to collect the dump.
> 
> From the README it appears to me that makedumpfile can get vmcoreinfo
> from /proc/vmcore
> Is there any special CONFIG needed to support this?

hmm, at least CONFIG_CRASH_CORE=y would be needed.

Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
