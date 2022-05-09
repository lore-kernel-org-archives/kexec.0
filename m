From: Baoquan He <bhe@redhat.com>
Date: Mon, 9 May 2022 12:05:21 +0800
Subject: [PATCH v24 6/6] docs: kdump: Update the crashkernel description
 for arm64
In-Reply-To: <Yna5AVli1IIUd2kg@arm.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-7-thunder.leizhen@huawei.com>
 <20220506231451.GB122876@MiWiFi-R3L-srv>
 <6e662eae-e788-13d3-368a-e88ed159fc85@huawei.com>
 <YnXn87JnfUxI2lC2@MiWiFi-R3L-srv> <Yna5AVli1IIUd2kg@arm.com>
Message-ID: <YniTAbNIfaLKhFWK@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/07/22 at 07:22pm, Catalin Marinas wrote:
> On Sat, May 07, 2022 at 11:30:59AM +0800, Baoquan He wrote:
> > On 05/07/22 at 09:41am, Leizhen (ThunderTown) wrote:
> > > On 2022/5/7 7:14, Baoquan He wrote:
> > > > On 05/06/22 at 07:44pm, Zhen Lei wrote:
> > > >> Now arm64 has added support for "crashkernel=X,high" and
> > > >> "crashkernel=Y,low". Unlike x86, crash low memory is not allocated if
> > > >> "crashkernel=Y,low" is not specified.
> > > >>
> > > >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > > >> ---
> > > >>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
> > > >>  1 file changed, 7 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > >> index 3f1cc5e317ed4a5..aa44c61114aa4b8 100644
> > > >> --- a/Documentation/admin-guide/kernel-parameters.txt
> > > >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > >> @@ -808,7 +808,7 @@
> > > >>  			Documentation/admin-guide/kdump/kdump.rst for an example.
> > > >>  
> > > >>  	crashkernel=size[KMG],high
> > > >> -			[KNL, X86-64] range could be above 4G. Allow kernel
> > > >> +			[KNL, X86-64, ARM64] range could be above 4G. Allow kernel
> > > >>  			to allocate physical memory region from top, so could
> > > >>  			be above 4G if system have more than 4G ram installed.
> > > >>  			Otherwise memory region will be allocated below 4G, if
> > > >> @@ -821,7 +821,7 @@
> > > >>  			that require some amount of low memory, e.g. swiotlb
> > > >>  			requires at least 64M+32K low memory, also enough extra
> > > >>  			low memory is needed to make sure DMA buffers for 32-bit
> > > >> -			devices won't run out. Kernel would try to allocate at
> > > >> +			devices won't run out. Kernel would try to allocate
> > > >>  			at least 256M below 4G automatically.
> > > >>  			This one let user to specify own low range under 4G
> > > >>  			for second kernel instead.
> > > >> @@ -829,6 +829,11 @@
> > > >>  			It will be ignored when crashkernel=X,high is not used
> > > >>  			or memory reserved is below 4G.
> > > >>  
> > > >> +			[KNL, ARM64] range in low memory.
> > > >> +			This one let user to specify a low range in DMA zone for
> > > >                                           ^ not needed,
> > > >                         Maybe Catalin can fix it when merging.
> > > 
> > > Delete "This one let user to" or the entire sentence? I understand it to be the former.
> > 
> > Oh, I mean the 'to' is not needed. "This one let user specify ....". The
> > 'to' is a grammer mistake.
> 
> Slightly more correct is "This one lets the user specify..."
> 
> I can fix them up when applying.

Right, thx.


