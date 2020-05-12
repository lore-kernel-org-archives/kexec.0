Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400040.outbound.protection.outlook.com
 ([40.107.140.40] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYaSR-0001Jz-0e
 for kexec@lists.infradead.org; Tue, 12 May 2020 19:20:52 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [REQUEST] makedumpfile: stream compress flat ELF format with libz
Date: Tue, 12 May 2020 19:20:44 +0000
Message-ID: <OSBPR01MB199106310D313355302BDE9ADDBE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200512172546.GL31850@zorba>
In-Reply-To: <20200512172546.GL31850@zorba>
Content-Language: en-US
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
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>

> -----Original Message-----
>
> Hi,
>
> I created an enhancement request for makedumpfile here,
>
> https://github.com/makedumpfile/makedumpfile/issues/1
>
> I found that compressing a flat core with gzip significantly reduces the size of
> the core. Here were my findings,
>
> 32G flat elf core -E -F -d 0
> 33G kdump core -d 0
> 16G kdump compressed -c -d 0
> 1.9G flat elf core stream compressed with gzip -E -F -d 0

The kdump-compressed format does per-page compression with compression level 1,
so depending on data in vmcore, gzip (with -6 by default) can compress one much
smaller like this.  Although I don't have a vmcore that shows such a drop in size
with gzip as far as I tested.

>
> My feature request was to implement an option inside makedumpfile to gzip
> compress the core output. This can already be accomplished by piping the core
> thru the gzip tool, however, because makedumpfile already links against libz
> having the option for makedumpfile to do it allows the gzip tools to be removed
> from the crash kernels initramfs there by reducing the size.

(personally I prefer piping it through gzip, but apparently there are cases where
the initramfs size needs to be minimized..)

>
> Kazuhito Hagio had suggest adding the -C option instead of repurposing -c to do
> this.
>
> So a resulting command line might looks like this,
>
> makedumpfile -C -F -E -d 31 /proc/vmcore core.gz

Yes, the existing -c option is for per-page compression and creates a dumpfile that
can be opened directly with crash utility, but stream compression is different.
So I'd like to separate it from the -c.

(as John commented, -z also might be good, but I wonder if someone might start to
want the same function with lzo or snappy..)

Anyway, I'll wait for patches for this enhancement.

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
