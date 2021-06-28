Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1310078.outbound.protection.outlook.com
 ([40.107.131.78] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxlMg-0079uo-Mu
 for kexec@lists.infradead.org; Mon, 28 Jun 2021 07:07:32 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: Compiling makedumpfile from source
Date: Mon, 28 Jun 2021 07:07:23 +0000
Message-ID: <TYYPR01MB677737A58CFA82D3F238E515DD039@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <TYYPR01MB67770864ECE9A641AE5BDAA9DD349@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <CAB6A5-DWGtWo5iQGM_ApTXU5bGL-V2mEbFhEapuABAHwXagezA@mail.gmail.com>
In-Reply-To: <CAB6A5-DWGtWo5iQGM_ApTXU5bGL-V2mEbFhEapuABAHwXagezA@mail.gmail.com>
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
> Hi Kazuhito san,
> 
> I am getting the following error when trying to use makedumpfile utility.
> 
> > copy_vmcoreinfo: Can't open the vmcoreinfo file(/tmp/vmcoreinfoLUQc25). No such file or directory.
> > makedumpfile Failed
> 
> In your setup how are you providing the vmcoreinfo file? In my case it
> is checking /tmp/vmcoreinfoLUQc25
> Who generates this file?

Generally, vmcoreinfo is copied from vmcore's ELF note to /tmp/vmcoreinfoXXXXXX
by makedumpfile, please see copy_vmcoreinfo().  So no need to provide explicitly.

Is there the /tmp directory on your environment?

Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
