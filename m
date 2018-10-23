Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
From: Joe Perches <joe@perches.com>
Date: Mon, 22 Oct 2018 21:15:37 -0700
In-Reply-To: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
Mime-Version: 1.0
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
To: Arun KS <arunks@codeaurora.org>, Guo Ren <ren_guo@c-sky.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter
 Anvin" <hpa@zytor.com>, x86@kernel.org, David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Minghsiu Tsai <minghsiu.tsai@mediatek.com>, Houlong Wei <houlong.wei@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Xavier Deguillard <xdeguillard@vmware.com>, Nadav Amit <namit@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>, "James
 E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, "J. Bruce Fields" <bfields@fieldses.org>, Jeff Layton <jlayton@kernel.org>, Anton Altaparmakov <anton@tuxera.com>, Alexey Dobriyan <adobriyan@gmail.com>, Eric Biederman <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, Gerrit Renker <gerrit@erg.abdn.ac.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Florian Westphal <fw@strlen.de>, Vlad Yasevich <vyasevich@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mark Brown <broonie@kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>, Cyril Bur <cyrilbur@gmail.com>, Russell Currey <ruscur@russell.cc>, Michal Hocko <mhocko@suse.com>, Chris Wilson <chris@chris-wilson.co.uk>, Matthew Auld <matthew.auld@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>, Mika Kuoppala <mika.kuoppala@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Khalid Aziz <khalid@gonehiking.org>, Matthew Wilcox <willy@infradead.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Souptick Joarder <jrdr.linux@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>, Petr Tesarik <ptesarik@suse.com>, Jia He <jia.he@hxt-semitech.com>, Minchan Kim <minchan@kernel.org>, Huang Ying <ying.huang@intel.com>, Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, Omar Sandoval <osandov@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Jonathan Corbet <corbet@lwn.net>, Stefan Agner <stefan@agner.ch>, Daniel Vacek <neelx@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Hildenbrand <david@redhat.com>, Mathieu Malaterre <malat@debian.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Yang Shi <yang.shi@linux.alibaba.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, YueHaibing <yuehaibing@huawei.com>, Shakeel Butt <shakeelb@google.com>, Chintan Pandya <cpandya@codeaurora.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Jann Horn <jannh@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Steven J. Hill" <steven.hill@cavium.com>, Kemi Wang <kemi.wang@intel.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, devel@linuxdriverproject.org, linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-parisc@vger.kernel.org, devel@driverdev.osuosl.org, linaro-mm-sig@lists.linaro.org, xen-devel@lists.xenproject.org, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, linux-mm@kvack.org, kexec@lists.infradead.org, linux-pm@vger.kernel.org, kasan-dev@googlegroups.com, dccp@vger.kernel.org, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-sctp@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: getarunks@gmail.com

On Mon, 2018-10-22 at 22:53 +0530, Arun KS wrote:
> Remove managed_page_count_lock spinlock and instead use atomic
> variables.

Perhaps better to define and use macros for the accesses
instead of specific uses of atomic_long_<inc/dec/read>

Something like:

#define totalram_pages()	(unsigned long)atomic_long_read(&_totalram_pages)
#define totalram_pages_inc()	(unsigned long)atomic_long_inc(&_totalram_pages)
#define totalram_pages_dec()	(unsigned long)atomic_long_dec(&_totalram_pages)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
