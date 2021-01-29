Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400051.outbound.protection.outlook.com
 ([40.107.140.51] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5NBU-0003Cz-HT
 for kexec@lists.infradead.org; Fri, 29 Jan 2021 06:23:09 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [External] RE: Makedumpfile compile errors on Debian 10
Date: Fri, 29 Jan 2021 06:23:03 +0000
Message-ID: <OSBPR01MB19913AD2E803DA4952270E3DDDB99@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <CAP_N_Z8k_TXjbCL-mEF-OY37vB-wo8PVOoz85s3Qp6Q7yzQQVg@mail.gmail.com>
 <OSBPR01MB1991FCB292F9584678AB01A9DDB99@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <CAP_N_Z-t8v0maLe9jTDPPjYe9933JxymXGpyy6LONQ23EuYRnA@mail.gmail.com>
In-Reply-To: <CAP_N_Z-t8v0maLe9jTDPPjYe9933JxymXGpyy6LONQ23EuYRnA@mail.gmail.com>
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
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Cc: kexec <kexec@lists.infradead.org>

-----Original Message-----
> Hi Kazu,
> 
> I see. I will post a patch for this. I will try 1.6.8 to see if it
> works for me or not. Thanks for the info.

oh, please note that 1.6.8's --dump-dmesg does not support kernel 5.10,
which has the new printk ringbuffer, it needs the following two patches
in the master branch:

44b073b7ec46 [PATCH 2/2] printk: use committed/finalized state values
c617ec633392 [PATCH 1/2] printk: add support for lockless ringbuffer

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
