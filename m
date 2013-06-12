Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UmoEu-0003Eu-SL
 for kexec@lists.infradead.org; Wed, 12 Jun 2013 16:49:42 +0000
Date: Wed, 12 Jun 2013 11:49:19 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: kexec: purgatory hang
Message-ID: <20130612164919.GB16154@sgi.com>
References: <E1UmXSQ-0008Nq-27@eag09.americas.sgi.com>
 <CAE9FiQWaAqGi5iGj+=ET4_D3OxuSjpHpMKAmOk--YHXMx_wJ-A@mail.gmail.com>
 <CAE9FiQXPk8ix36MByC5GJrV5eE4ApPHBzKVSJqOqc+vG4eKqUA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE9FiQXPk8ix36MByC5GJrV5eE4ApPHBzKVSJqOqc+vG4eKqUA@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Jun 11, 2013 at 09:14:19PM -0700, Yinghai Lu wrote:
> On Tue, Jun 11, 2013 at 6:45 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Tue, Jun 11, 2013 at 3:54 PM, Cliff Wickman <cpw@sgi.com> wrote:
> >>
> >> I'm getting a hang when trying to enter a high-memory crash kernel,
> >> and I'm at a loss as to how to debug this.
> >>
> >> This is a 3.10.0-rc3 kernel, and set up as the crash kernel by kexec 2.0.4.
> >> The machine is an SGI UV1000.
> >
> > what is your mem size?

uv21-sys:~ # head /proc/meminfo
MemTotal:       726897840 kB
 
> also can you post your /proc/iomem in first kernel?

This is /proc/iomem after asking for crashkernel=900M,high

But I also get the same result specifying lower addresses, such
as crashkernel=900M@256G

00000000-00000fff : reserved
00001000-0008efff : System RAM
0008f000-0008ffff : ACPI Non-volatile Storage
00090000-0009ffff : System RAM
000c0000-000c7fff : Video ROM
000cc000-000d1bff : Adapter ROM
000f0000-000fffff : System ROM
00100000-75958fff : System RAM
  01000000-0153feab : Kernel code
  0153feac-01ae703f : Kernel data
  01c93000-01e1efff : Kernel bss
  6d000000-717fffff : Crash kernel low
75959000-7597cfff : Unusable memory
7597d000-7597efff : System RAM
7597f000-7597ffff : reserved
75980000-75980fff : System RAM
75981000-75981fff : reserved
75982000-75c5efff : System RAM
75c5f000-75c63fff : Unusable memory
75c64000-75c6cfff : System RAM
75c6d000-75c75fff : reserved
75c76000-75ca3fff : System RAM
75ca4000-75cabfff : Unusable memory
75cac000-75cb3fff : System RAM
75cb4000-75cb5fff : Unusable memory
75cb6000-75cfefff : System RAM
75cff000-75d18fff : Unusable memory
75d19000-75d22fff : System RAM
75d23000-75d24fff : reserved
75d25000-75d25fff : System RAM
75d26000-75d28fff : reserved
75d29000-7617bfff : System RAM
7617c000-761abfff : Unusable memory
761ac000-76261fff : System RAM
76262000-76263fff : Unusable memory
76264000-76278fff : System RAM
76279000-7627bfff : Unusable memory
7627c000-76289fff : System RAM
7628a000-7628ffff : Unusable memory
76290000-76296fff : System RAM
76297000-7629efff : Unusable memory
7629f000-76476fff : System RAM
76477000-76482fff : reserved
76483000-78b20fff : System RAM
78b21000-78b22fff : reserved
78b23000-78b24fff : Unusable memory
78b25000-78b26fff : reserved
78b27000-78b30fff : Unusable memory
78b31000-78b56fff : reserved
78b57000-78b60fff : Unusable memory
78b61000-78b70fff : reserved
78b71000-78bc0fff : Unusable memory
78bc1000-78c10fff : reserved
  78bc6018-78bc6027 : APEI ERST
  78bc6030-78bc606f : APEI ERST
  78bc6070-78bc8017 : APEI ERST
78c11000-78c73fff : ACPI Non-volatile Storage
78c74000-78ce8fff : ACPI Tables
78ce9000-78d10fff : ACPI Non-volatile Storage
78d11000-78d30fff : ACPI Tables
78d31000-7cda1fff : System RAM
7cda2000-7cda2fff : reserved
7cda3000-7cdb4fff : System RAM
7cdb5000-7ce34fff : reserved
7ce35000-7effffff : System RAM
7f000000-7fffffff : RAM buffer
80000000-8fffffff : reserved
  80000000-806fffff : PCI MMCONFIG 0000 [bus 00-06]
90000000-970fffff : PCI Bus 0003:01
  90000000-970fffff : PCI Bus 0003:02
    90000000-970fffff : PCI Bus 0003:05
      90000000-970fffff : PCI Bus 0003:06
        90000000-930fffff : PCI Bus 0003:08
          90000000-91ffffff : 0003:08:00.0
          92000000-92ffffff : 0003:08:00.0
          93000000-9307ffff : 0003:08:00.0
        94000000-970fffff : PCI Bus 0003:07
          94000000-95ffffff : 0003:07:00.0
          96000000-96ffffff : 0003:07:00.0
          97000000-9707ffff : 0003:07:00.0
97100000-97103fff : 0003:00:16.0
  97100000-97103fff : ioatdma
97104000-97107fff : 0003:00:16.1
  97104000-97107fff : ioatdma
97108000-9710bfff : 0003:00:16.2
  97108000-9710bfff : ioatdma
9710c000-9710ffff : 0003:00:16.3
  9710c000-9710ffff : ioatdma
97110000-97113fff : 0003:00:16.4
  97110000-97113fff : ioatdma
97114000-97117fff : 0003:00:16.5
  97114000-97117fff : ioatdma
97118000-9711bfff : 0003:00:16.6
  97118000-9711bfff : ioatdma
9711c000-9711ffff : 0003:00:16.7
  9711c000-9711ffff : ioatdma
97120000-97120fff : 0003:00:13.0
b0000000-b0ffffff : PCI Bus 0000:05
  b0000000-b0ffffff : 0000:05:00.0
    b0000000-b03a9fff : efifb
b1000000-b18fffff : PCI Bus 0000:05
  b1000000-b17fffff : 0000:05:00.0
  b1800000-b180ffff : 0000:05:00.0
  b1810000-b1813fff : 0000:05:00.0
b1c00000-b20fffff : PCI Bus 0000:04
  b1c00000-b1ffffff : 0000:04:00.0
  b2000000-b200ffff : 0000:04:00.0
    b2000000-b200ffff : mpt
  b2010000-b2013fff : 0000:04:00.0
    b2010000-b2013fff : mpt
b2100000-b22fffff : PCI Bus 0000:01
  b2100000-b211ffff : 0000:01:00.1
  b2120000-b213ffff : 0000:01:00.1
    b2120000-b213ffff : igb
  b2140000-b215ffff : 0000:01:00.1
    b2140000-b215ffff : igb
  b2160000-b217ffff : 0000:01:00.0
  b2180000-b219ffff : 0000:01:00.0
    b2180000-b219ffff : igb
  b21a0000-b21bffff : 0000:01:00.0
    b21a0000-b21bffff : igb
  b21c0000-b21dffff : 0000:01:00.0
  b21e0000-b21fffff : 0000:01:00.0
  b2200000-b221ffff : 0000:01:00.1
  b2220000-b223ffff : 0000:01:00.1
  b2240000-b2243fff : 0000:01:00.1
    b2240000-b2243fff : igb
  b2244000-b2247fff : 0000:01:00.0
    b2244000-b2247fff : igb
b2300000-b2303fff : 0000:00:16.0
  b2300000-b2303fff : ioatdma
b2304000-b2307fff : 0000:00:16.1
  b2304000-b2307fff : ioatdma
b2308000-b230bfff : 0000:00:16.2
  b2308000-b230bfff : ioatdma
b230c000-b230ffff : 0000:00:16.3
  b230c000-b230ffff : ioatdma
b2310000-b2313fff : 0000:00:16.4
  b2310000-b2313fff : ioatdma
b2314000-b2317fff : 0000:00:16.5
  b2314000-b2317fff : ioatdma
b2318000-b231bfff : 0000:00:16.6
  b2318000-b231bfff : ioatdma
b231c000-b231ffff : 0000:00:16.7
  b231c000-b231ffff : ioatdma
b2320000-b23203ff : 0000:00:1d.7
b2321000-b23213ff : 0000:00:1a.7
  b2321000-b23213ff : ehci_hcd
b2322000-b23220ff : 0000:00:1f.3
b2323000-b2323fff : 0000:00:13.0
b3000000-b3003fff : 0001:00:16.0
  b3000000-b3003fff : ioatdma
b3004000-b3007fff : 0001:00:16.1
  b3004000-b3007fff : ioatdma
b3008000-b300bfff : 0001:00:16.2
  b3008000-b300bfff : ioatdma
b300c000-b300ffff : 0001:00:16.3
  b300c000-b300ffff : ioatdma
b3010000-b3013fff : 0001:00:16.4
  b3010000-b3013fff : ioatdma
b3014000-b3017fff : 0001:00:16.5
  b3014000-b3017fff : ioatdma
b3018000-b301bfff : 0001:00:16.6
  b3018000-b301bfff : ioatdma
b301c000-b301ffff : 0001:00:16.7
  b301c000-b301ffff : ioatdma
b3020000-b3020fff : 0001:00:13.0
b4000000-b4003fff : 0002:00:16.0
  b4000000-b4003fff : ioatdma
b4004000-b4007fff : 0002:00:16.1
  b4004000-b4007fff : ioatdma
b4008000-b400bfff : 0002:00:16.2
  b4008000-b400bfff : ioatdma
b400c000-b400ffff : 0002:00:16.3
  b400c000-b400ffff : ioatdma
b4010000-b4013fff : 0002:00:16.4
  b4010000-b4013fff : ioatdma
b4014000-b4017fff : 0002:00:16.5
  b4014000-b4017fff : ioatdma
b4018000-b401bfff : 0002:00:16.6
  b4018000-b401bfff : ioatdma
b401c000-b401ffff : 0002:00:16.7
  b401c000-b401ffff : ioatdma
b4020000-b4020fff : 0002:00:13.0
b5000000-b50fffff : PCI Bus 0004:02
  b5000000-b5001fff : 0004:02:00.0
    b5000000-b5001fff : xhci_hcd
b5100000-b5103fff : 0004:00:16.0
  b5100000-b5103fff : ioatdma
b5104000-b5107fff : 0004:00:16.1
  b5104000-b5107fff : ioatdma
b5108000-b510bfff : 0004:00:16.2
  b5108000-b510bfff : ioatdma
b510c000-b510ffff : 0004:00:16.3
  b510c000-b510ffff : ioatdma
b5110000-b5113fff : 0004:00:16.4
  b5110000-b5113fff : ioatdma
b5114000-b5117fff : 0004:00:16.5
  b5114000-b5117fff : ioatdma
b5118000-b511bfff : 0004:00:16.6
  b5118000-b511bfff : ioatdma
b511c000-b511ffff : 0004:00:16.7
  b511c000-b511ffff : ioatdma
b5120000-b5120fff : 0004:00:13.0
f0000000-fbffffff : reserved
fd020000-fd020fff : dmar0
fd040000-fd040fff : dmar1
fd060000-fd060fff : dmar2
fd080000-fd080fff : dmar3
fd0a0000-fd0a0fff : dmar4
feb00000-febfffff : reserved
fec00000-fec003ff : IOAPIC 0
fec02000-fec023ff : IOAPIC 1
fec04000-fec043ff : IOAPIC 2
fec06000-fec063ff : IOAPIC 3
fec08000-fec083ff : IOAPIC 4
fec0a000-fec0a3ff : IOAPIC 5
fed00000-fed003ff : HPET 0
fed12000-fed1200f : pnp 00:06
fed12010-fed1201f : pnp 00:06
fed1b000-fed1bfff : pnp 00:06
fed1c000-fed3ffff : pnp 00:06
  fed1f410-fed1f414 : iTCO_wdt
fed45000-fed8bfff : pnp 00:06
fee00000-feefffff : pnp 00:06
ff000000-ffffffff : pnp 00:06
100000000-207fffffff : System RAM
4000000000-5ffeffffff : System RAM
5fff000000-5fffffffff : RAM buffer
8000000000-9ffeffffff : System RAM
9fff000000-9fffffffff : RAM buffer
c000000000-cffeffffff : System RAM
cfff000000-cfffffffff : RAM buffer
10000000000-11ffeffffff : System RAM
11fff000000-11fffffffff : RAM buffer
14000000000-15ffeffffff : System RAM
  15fc6000000-15ffe3fffff : Crash kernel
15fff000000-15fffffffff : RAM buffer
1fd80000000-1fd83cfffff : reserved
1fd83e00000-1fd83ffffff : PCI MMCONFIG 1000 [bus 3e-3f]
  1fd83e00000-1fd83ffffff : reserved
1fd87e00000-1fd8bcfffff : reserved
  1fd87e00000-1fd87ffffff : PCI MMCONFIG 1001 [bus 3e-3f]
  1fd88000000-1fd882fffff : PCI MMCONFIG 0001 [bus 00-02]
1fd8be00000-1fd8fcfffff : reserved
  1fd8be00000-1fd8bffffff : PCI MMCONFIG 1002 [bus 3e-3f]
  1fd8c000000-1fd8c2fffff : PCI MMCONFIG 0002 [bus 00-02]
1fd8fe00000-1fd93cfffff : reserved
  1fd8fe00000-1fd8fffffff : PCI MMCONFIG 1003 [bus 3e-3f]
  1fd90000000-1fd90afffff : PCI MMCONFIG 0003 [bus 00-0a]
1fd93e00000-1fd97cfffff : reserved
  1fd93e00000-1fd93ffffff : PCI MMCONFIG 1004 [bus 3e-3f]
  1fd94000000-1fd942fffff : PCI MMCONFIG 0004 [bus 00-02]
1fd97e00000-1fd97ffffff : PCI MMCONFIG 1005 [bus 3e-3f]
  1fd97e00000-1fd97ffffff : reserved
1fdc0000000-1fdc2ffffff : reserved
1fdc4000000-1fdc6ffffff : reserved
1fdc8000000-1fdcaffffff : reserved
1fdcc000000-1fdceffffff : reserved
1fdd0000000-1fdd2ffffff : reserved
1fdd4000000-1fdd6ffffff : reserved
1ff00000000-1ff1fffffff : PCI Bus 0003:01
  1ff00000000-1ff1fffffff : PCI Bus 0003:02
    1ff00000000-1ff1fffffff : PCI Bus 0003:05
      1ff00000000-1ff1fffffff : PCI Bus 0003:06
        1ff00000000-1ff0fffffff : PCI Bus 0003:08
          1ff00000000-1ff0fffffff : 0003:08:00.0
        1ff10000000-1ff1fffffff : PCI Bus 0003:07
          1ff10000000-1ff1fffffff : 0003:07:00.0

-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
