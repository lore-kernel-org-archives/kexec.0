Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNm8e-00021H-Or
 for kexec@lists.infradead.org; Wed, 12 Mar 2014 16:36:18 +0000
From: "Sumner, William" <bill.sumner@hp.com>
Subject: FW: Re: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
Date: Wed, 12 Mar 2014 16:34:18 +0000
Message-ID: <875D89B79D1D86448A583A7302C022A066E093DB@G4W3212.americas.hpqcorp.net>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>, "bhe@redhat.com" <bhe@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "joro@8bytes.org" <joro@8bytes.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Li,
 Zhen-Hua" <zhen-hual@hp.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Hatch, Douglas B (HPS Linux PM)" <doug.hatch@hp.com>, "ishii.hironobu@jp.fujitsu.com" <ishii.hironobu@jp.fujitsu.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>

Resending as plain-text.
Bill

From: Sumner, William =

Sent: Wednesday, March 12, 2014 11:15 AM
To: 'Vivek Goyal'
Cc: dwmw2@infradead.org; indou.takao@jp.fujitsu.com; bhe@redhat.com; joro@8=
bytes.org; linux-pci@vger.kernel.org; kexec@lists.infradead.org; alex.willi=
amson@redhat.com; linux-kernel@vger.kernel.org; iommu@lists.linux-foundatio=
n.org; ddutile@redhat.com; Hatch, Douglas B (HPS Linux PM); ishii.hironobu@=
jp.fujitsu.com; bhelgaas@google.com; Li, Zhen-Hua
Subject: Re: [PATCHv3 0/6] Crashdump Accepting Active IOMMU

On Mon, Mar 10, 2014 at 04:43PM, Vivek Goyal wrote:
>On Fri, Jan 10, 2014 at 03:07:26PM -0700, Bill Sumner wrote:
>
>[..]
>> This patch set modifies the behavior of the iommu in the (new) crashdump=
 kernel:
>> 1. to accept the iommu hardware in an active state, 2. to leave the
>> current translations in-place so that legacy DMA will continue
>>=A0=A0=A0 using its current buffers until the device drivers in the crash=
dump kernel>>=A0=A0=A0 initialize and initialize their devices, 3. to use d=
ifferent
>> portions of the iova address ranges for the device drivers
>>=A0=A0=A0 in the crashdump kernel than the iova ranges that were in-use a=
t the time
>>=A0=A0=A0 of the panic.
>
>Conceptually, above makes sense to me. I have few queries.
>
>- Do we need to pass any kind of data from first kernel to second kernel,
>=A0 like table size etc? Calgary IOMMU was using first kernel's tables
>=A0 also and it was determining previous kernel's table size using saved_m=
ax_pfn.

Yes. We need to pass the intel-iommu translation tables from the first kern=
el to the second kernel - well, to allow the second kernel to read them.=A0=
 Only the tree of tables that the intel-iommu hardware references are neede=
d: the root-entry table, the context-entry tables, and the page-translation=
 tables.=A0 This patch involves only the intel-iommu -- and none of the oth=
er iommu hardware types.

During the early initialization of the new kdump kernel this patch copies (=
duplicates) the tree of iommu translation tables from the old kernel into t=
he new kernel.=A0 These tables are all linked together as a tree by physica=
l memory addresses. The physical address of the top of the tree -- the root=
-entry table -- is obtained from a register in the iommu hardware. The copy=
 operation traverses the tree in depth-first order, sanity-checking each ta=
ble and then duplicating it into the kernel address space of the new kernel=
, linking the new tables appropriately.=A0 If the copy succeeds then the io=
mmu register is updated to point to the copy in the new kernel and the iomm=
u continues translating DMA requests from IO devices.=A0 If a sanity-check =
fails, the patch currently errors-out of the dump (might want to revisit th=
is error case and see if there is something better to do.)

By copying the tables into the new kernel, all of the existing code in inte=
l-iommu.c continues to work nearly unchanged, with only a few added initial=
izations of fields when kdump is active and when intel-iommu.c creates its =
"bookkeeping" structures for the device -- to make sure they correspond to =
the contents of the translate tables. I made a determined effort to avoid c=
hanging the existing execution path for the non-kdump case, and to minimize=
 the changes even when kdump is active.=A0 =


Note also that this leaves the copy of the translate tables in the old pani=
cked kernel unused and unchanged during the operation of 'makedumpfile', so=
 they appear correctly in the dump as they were at the time of the panic.

>
>- I don't know how IOMMU translation tables look like, but are new DMA
>=A0 zones setup by drivers in second kernel part of same table?

Yes. The copied translation tables in the kdump kernel contain both the tra=
nslations that were active at the time of the dump (which will never go awa=
y until the dump is finished and the platform is rebooted), plus any transl=
ations needed by the kdump kernel (which come and go as necessary).=A0 As t=
he "bookkeeping" structures are created in the new kernel (typically the fi=
rst time that a device requests a translation for a buffer) they are initia=
lized such that all IOVAs that already exist in the translate tables for th=
t device are marked as "not available for allocation" so all requests by de=
vice drivers in the new kernel receive IOVAs that were not in-use at the ti=
me of the panic.

> How do we
>=A0 make sure that sufficient space is available.

So far I have not seen any problem with running out of space because of thi=
s copy; =A0however, I believe that this may be a valid concern with very la=
rge IO configurations -- and it deserves some attention as the community re=
views and tests this patch.

> I am not sure if possible
>=A0 table corruption from crashed kernel is an issue here or not.

Any corrupted translation tables from the crashed kernel would be a problem=
 that would prevent using copies of them. I hope and expect that this happe=
ns rarely -- and that we would catch it during the copy when it does.

Fortunately, these tables are only manipulated by the code in intel-iommu.c=
 - which limits the amount of code that has to be "right".=A0 Of course, th=
ere is always the possibility that other code in the kernel could "hose" on=
e of these tables -- so we need to sanity-check the tables before the new k=
ernel uses them.

>
>In general, I think changelogs of these patches need to be little better.
>There seem to be lot of text and still I can't quickly wrap my head around=
 what a particular patch is supposed to be doing.

I will work on the changelogs as I re-arrange the code and the structure of=
 the patch-set for the next submitted version.

>
>But we definitely need to fix this issue. IOMMU issues with kdump have bee=
n troubling us for a very long time.
Strongly agree.

-- Bill

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
