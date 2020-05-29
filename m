Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 29 May 2020 09:05:39 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <20200529080539.GC4351@willie-the-truck>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200526014242.GF20045@MiWiFi-R3L-srv>
 <897ea1b9-a68c-8544-6532-a21be135ce01@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <897ea1b9-a68c-8544-6532-a21be135ce01@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: John Donnelly <John.P.donnelly@oracle.com>
Cc: horms@verge.net.au, devicetree@vger.kernel.org, arnd@arndb.de, Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, Chen Zhou <chenzhou10@huawei.com>, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mingo@redhat.com, james.morse@arm.com, guohanjun@huawei.com, tglx@linutronix.de, pkushwaha@marvell.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

[+James Morse]

On Thu, May 28, 2020 at 05:20:34PM -0500, John Donnelly wrote:
> On 5/25/20 8:42 PM, Baoquan He wrote:
> > On 05/21/20 at 05:38pm, Chen Zhou wrote:
> > > This patch series enable reserving crashkernel above 4G in arm64.

[...]

> > > Chen Zhou (5):
> > >    x86: kdump: move reserve_crashkernel_low() into crash_core.c
> > >    arm64: kdump: reserve crashkenel above 4G for crash dump kernel
> > >    arm64: kdump: add memory for devices by DT property, low-memory-ra=
nge
> > >    kdump: update Documentation about crashkernel on arm64
> > >    dt-bindings: chosen: Document linux,low-memory-range for arm64 kdu=
mp
> > > =

> > >   Documentation/admin-guide/kdump/kdump.rst     | 13 ++-
> > >   .../admin-guide/kernel-parameters.txt         | 12 ++-
> > >   Documentation/devicetree/bindings/chosen.txt  | 25 ++++++
> > >   arch/arm64/kernel/setup.c                     |  8 +-
> > >   arch/arm64/mm/init.c                          | 61 ++++++++++++-
> > >   arch/x86/kernel/setup.c                       | 66 ++------------
> > >   include/linux/crash_core.h                    |  3 +
> > >   include/linux/kexec.h                         |  2 -
> > >   kernel/crash_core.c                           | 85 ++++++++++++++++=
+++
> > >   kernel/kexec_core.c                           | 17 ----
> > >   10 files changed, 208 insertions(+), 84 deletions(-)
> > > =

> This proposal to improve vmcore creation on Arm=A0 has been going on for
> almost a year now.
> =

> Who is the=A0 final maintainer that needs to approve and except these ?
> =

> What are the lingering issues that are remaining so we get these accepted
> into a upstream commit ?

The arm64 bits need an Ack from James Morse, but he's not on CC despite
offering feedback on earlier versions.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
