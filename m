Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 22 Nov 2018 09:33:10 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
Message-ID: <20181122013310.GA20480@guoren-Inspiron-7460>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
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
To: Arun KS <arunks@codeaurora.org>
Cc: Mike Snitzer <snitzer@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kemi Wang <kemi.wang@intel.com>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, linux-sctp@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Christoph Lameter <cl@linux.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Petr Tesarik <ptesarik@suse.com>, Michael Ellerman <mpe@ellerman.id.au>, ceph-devel@vger.kernel.org, James Morris <jmorris@namei.org>, kasan-dev@googlegroups.com, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, "Steven J. Hill" <steven.hill@cavium.com>, David Rientjes <rientjes@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Daniel Vacek <neelx@redhat.com>, Roman Gushchin <guro@fb.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, linux-um@lists.infradead.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anton Altaparmakov <anton@tuxera.com>, linux-parisc@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Cyril Bur <cyrilbur@gmail.com>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, netfilter-devel@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, David Airlie <airlied@linux.ie>, dm-devel@redhat.com, Nadav Amit <namit@vmware.com>, Omar Sandoval <osandov@fb.com>, Alasdair Kergon <agk@redhat.com>, linux-s390@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, intel-gfx@lists.freedesktop.org, Helge Deller <deller@gmx.de>, Hugh Dickins <hughd@google.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, coreteam@netfilter.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-media@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, Todd Kjos <tkjos@android.com>, Philippe Ombredanne <pombredanne@nexb.com>, Jani Nikula <jani.nikula@linux.intel.com>, Jia He <jia.he@hxt-semitech.com>, Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>, Houlong Wei <houlong.wei@mediatek.com>, devel@linuxdriverproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Martijn Coenen <maco@android.com>, linux-arm-kernel@lists.infradead.org, Khalid Aziz <khalid@gonehiking.org>, Oded Gabbay <oded.gabbay@gmail.com>, linaro-mm-sig@lists.linaro.org, linux-ntfs-dev@lists.sourceforge.net, Jonathan Corbet <corbet@lwn.net>, Florian Westphal <fw@strlen.de>, Anna Schumaker <anna.schumaker@netapp.com>, Pekka Enberg <penberg@kernel.org>, Minchan Kim <minchan@kernel.org>, Eric Biederman <ebiederm@xmission.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Kate Stewart <kstewart@linuxfoundation.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-fsdevel@vger.kernel.org, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Agner <stefan@agner.ch>, "James E.J. Bottomley" <jejb@parisc-linux.org>, netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org, Jan Kara <jack@suse.cz>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Gerrit Renker <gerrit@erg.abdn.ac.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Miklos Szeredi <miklos@szeredi.hu>, David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Matthew Auld <matthew.auld@intel.com>, Huang Ying <ying.huang@intel.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ilya Dryomov <idryomov@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>, "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>, Mark Brown <broonie@kernel.org>, Borislav Petkov <bp@alien8.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dan Williams <dan.j.williams@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Dan Streetman <ddstreet@ieee.org>, Oscar Salvador <osalvador@suse.de>, linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>, Jeff Layton <jlayton@kernel.org>, Eric Dumazet <edumazet@google.com>, Jessica Yu <jeyu@kernel.org>, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Minghsiu Tsai <minghsiu.tsai@mediatek.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "VMware,
 Inc." <pv-drivers@vmware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Russell Currey <ruscur@russell.cc>, Chris Wilson <chris@chris-wilson.co.uk>, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, getarunks@gmail.com, Chintan Pandya <cpandya@codeaurora.org>, devel@driverdev.osuosl.org, "Yan,
 Zheng" <zyan@redhat.com>, xen-devel@lists.xenproject.org, Sage Weil <sage@redhat.com>, dccp@vger.kernel.org, Richard Weinberger <richard@nod.at>, Seth Jennings <sjenning@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jeff Dike <jdike@addtoit.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Jann Horn <jannh@google.com>, Xavier Deguillard <xdeguillard@vmware.com>, Johannes Weiner <hannes@cmpxchg.org>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Tiffany Lin <tiffany.lin@mediatek.com>, linux-integrity@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Yang Shi <yang.shi@linux.alibaba.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, linuxppc-dev@lists.ozlabs.org, Vlad Yasevich <vyasevich@gmail.com>, linux-decnet-user@lists.sourceforge.net, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Mika Kuoppala <mika.kuoppala@linux.intel.com>, Mel Gorman <mgorman@techsingularity.net>

On Mon, Oct 22, 2018 at 10:53:22PM +0530, Arun KS wrote:
> Remove managed_page_count_lock spinlock and instead use atomic
> variables.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> 
> ---
> As discussed here,
> https://patchwork.kernel.org/patch/10627521/#22261253
> ---
> ---
>  arch/csky/mm/init.c                           |  4 +-
>  arch/powerpc/platforms/pseries/cmm.c          | 11 ++--
>  arch/s390/mm/init.c                           |  2 +-
>  arch/um/kernel/mem.c                          |  4 +-
>  arch/x86/kernel/cpu/microcode/core.c          |  5 +-
>  drivers/char/agp/backend.c                    |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
>  drivers/gpu/drm/i915/i915_gem.c               |  2 +-
>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  4 +-
>  drivers/hv/hv_balloon.c                       | 19 +++----
>  drivers/md/dm-bufio.c                         |  5 +-
>  drivers/md/dm-crypt.c                         |  4 +-
>  drivers/md/dm-integrity.c                     |  4 +-
>  drivers/md/dm-stats.c                         |  3 +-
>  drivers/media/platform/mtk-vpu/mtk_vpu.c      |  3 +-
>  drivers/misc/vmw_balloon.c                    |  2 +-
>  drivers/parisc/ccio-dma.c                     |  5 +-
>  drivers/parisc/sba_iommu.c                    |  5 +-
>  drivers/staging/android/ion/ion_system_heap.c |  2 +-
>  drivers/xen/xen-selfballoon.c                 |  7 +--
>  fs/ceph/super.h                               |  3 +-
>  fs/file_table.c                               |  9 ++--
>  fs/fuse/inode.c                               |  4 +-
>  fs/nfs/write.c                                |  3 +-
>  fs/nfsd/nfscache.c                            |  3 +-
>  fs/ntfs/malloc.h                              |  2 +-
>  fs/proc/base.c                                |  3 +-
>  include/linux/highmem.h                       |  2 +-
>  include/linux/mm.h                            |  2 +-
>  include/linux/mmzone.h                        | 10 +---
>  include/linux/swap.h                          |  2 +-
>  kernel/fork.c                                 |  6 +--
>  kernel/kexec_core.c                           |  5 +-
>  kernel/power/snapshot.c                       |  2 +-
>  lib/show_mem.c                                |  3 +-
>  mm/highmem.c                                  |  2 +-
>  mm/huge_memory.c                              |  2 +-
>  mm/kasan/quarantine.c                         |  4 +-
>  mm/memblock.c                                 |  6 +--
>  mm/memory_hotplug.c                           |  4 +-
>  mm/mm_init.c                                  |  3 +-
>  mm/oom_kill.c                                 |  2 +-
>  mm/page_alloc.c                               | 75 ++++++++++++++-------------
>  mm/shmem.c                                    | 12 +++--
>  mm/slab.c                                     |  3 +-
>  mm/swap.c                                     |  3 +-
>  mm/util.c                                     |  2 +-
>  mm/vmalloc.c                                  |  4 +-
>  mm/vmstat.c                                   |  4 +-
>  mm/workingset.c                               |  2 +-
>  mm/zswap.c                                    |  2 +-
>  net/dccp/proto.c                              |  6 +--
>  net/decnet/dn_route.c                         |  2 +-
>  net/ipv4/tcp_metrics.c                        |  2 +-
>  net/netfilter/nf_conntrack_core.c             |  6 +--
>  net/netfilter/xt_hashlimit.c                  |  4 +-
>  net/sctp/protocol.c                           |  6 +--
>  security/integrity/ima/ima_kexec.c            |  2 +-
>  58 files changed, 171 insertions(+), 143 deletions(-)
> 
> diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
> index dc07c07..3f4d35e 100644
> --- a/arch/csky/mm/init.c
> +++ b/arch/csky/mm/init.c
> @@ -71,7 +71,7 @@ void free_initrd_mem(unsigned long start, unsigned long end)
>  		ClearPageReserved(virt_to_page(start));
>  		init_page_count(virt_to_page(start));
>  		free_page(start);
> -		totalram_pages++;
> +		atomic_long_inc(&totalram_pages);
>  	}
>  }
>  #endif
> @@ -88,7 +88,7 @@ void free_initmem(void)
>  		ClearPageReserved(virt_to_page(addr));
>  		init_page_count(virt_to_page(addr));
>  		free_page(addr);
> -		totalram_pages++;
> +		atomic_long_inc(&totalram_pages);
>  		addr += PAGE_SIZE;
>  	}
For csky part, it's OK.

 Guo Ren

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
