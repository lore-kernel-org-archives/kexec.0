Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400083.outbound.protection.outlook.com
 ([40.107.140.83] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7ZtV-0003cH-22
 for kexec@lists.infradead.org; Thu, 04 Feb 2021 08:21:42 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [MAKEDUMPFILE PATCH 1/2] Add option to prevent writing the
 dumpfile
Date: Thu, 4 Feb 2021 08:21:36 +0000
Message-ID: <OSBPR01MB19914876E234C685E79B0FB6DDB39@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20201124104525.1070885-1-jthierry@redhat.com>
 <20201124104525.1070885-2-jthierry@redhat.com>
 <OSAPR01MB1986854BD0AEB2927A084DDCDDA40@OSAPR01MB1986.jpnprd01.prod.outlook.com>
 <OSBPR01MB199177A99EAA6F3A91CE49DADDBA9@OSBPR01MB1991.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB199177A99EAA6F3A91CE49DADDBA9@OSBPR01MB1991.jpnprd01.prod.outlook.com>
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
To: Julien Thierry <jthierry@redhat.com>, "lijiang@redhat.com" <lijiang@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Lianbo, Julien,

-----Original Message-----
> This patchset is applied with some modifications:
> https://github.com/makedumpfile/makedumpfile/compare/54aec38...6f3e75a
> 
> I will add another for counting bytes to be written and more readable stats later..

I've applied a patch to show write byte size.
https://github.com/makedumpfile/makedumpfile/commit/0ef2ca6c9fa2f61f217a4bf5d7fd70f24e12b2eb

I hope this is used rightly.

Thanks,
Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
