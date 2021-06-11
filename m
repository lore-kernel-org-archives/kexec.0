Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400077.outbound.protection.outlook.com
 ([40.107.140.77] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrVkA-0036Ul-3l
 for kexec@lists.infradead.org; Fri, 11 Jun 2021 01:13:57 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: Compiling makedumpfile from source
Date: Fri, 11 Jun 2021 01:13:45 +0000
Message-ID: <TYYPR01MB6777CB1ECE64ED0CF18FAE09DD349@TYYPR01MB6777.jpnprd01.prod.outlook.com>
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
To: manty kuma <mantykuma@gmail.com>, kexec-ml <kexec@lists.infradead.org>

Hi Manty,

-----Original Message-----
> What version of elfutils is needed by `makedumpfile`?
> elfutils-0.144 is mentioned in README.
> I tried this one but the compilation is broken.
> 
> https://sourceware.org/elfutils/ftp/0.144/
> 
> Should I try to use the latest one instead?

It could be built with elfutils-0.144 or later at the point of v1.6.7, and
I can build the latest makedumpfile with elfutils-0.148, 0.164, 0.182 on
some RHEL environments on hand with "make LINKTYPE=dynamic".

What command do you use to build?  and what error do you see?

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
