Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410045.outbound.protection.outlook.com
 ([40.107.141.45] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9I1l-006gGI-TQ
 for kexec@lists.infradead.org; Fri, 30 Jul 2021 02:13:35 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH v2 makedumpfile 0/3] Add option to limit file size
Date: Fri, 30 Jul 2021 02:13:28 +0000
Message-ID: <TYYPR01MB6777627C98AFB7AB5C849B13DDEC9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210708070611.291260-1-bpoirier@nvidia.com>
In-Reply-To: <20210708070611.291260-1-bpoirier@nvidia.com>
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
To: Benjamin Poirier <bpoirier@nvidia.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

-----Original Message-----
> See feature description in patch "Add -L option to limit output file
> size"
> 
> v1:
> 	http://lists.infradead.org/pipermail/kexec/2021-June/022728.html
> v2:
> 	Add patches 1, 2 to support dmesg limit with different kernel
> 	versions.
> 
> 	Stricter parsing of -L option value.
> 
> 	Instead of using RLIMIT_FSIZE, use write_bytes or SEEK_CUR to
> 	enforce limit. This better integrates with the -F option for
> 	stdout output.

sorry for the delay, and thank you for the update and fix.

Note that the v2 patchset cannot be built except for x86_64, so I moved
the memparse() from sadump_info.c to tools.c.  Otherwise, looks good.

https://github.com/makedumpfile/makedumpfile/compare/9df519d...f0cfa86

Thanks,
Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
