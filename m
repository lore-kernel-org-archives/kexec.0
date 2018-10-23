Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 23 Oct 2018 10:18:26 +0530
From: Arun KS <arunks@codeaurora.org>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
In-Reply-To: <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com>
Message-ID: <92d3523427e45124c71e16baabceb8c5@codeaurora.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joe Perches <joe@perches.com>
Cc: Mike Snitzer <snitzer@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kemi Wang <kemi.wang@intel.com>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, linux-sctp@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Christoph Lameter <cl@linux.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Petr Tesarik <ptesarik@suse.com>, Michael Ellerman <mpe@ellerman.id.au>, ceph-devel@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, "Steven J. Hill" <steven.hill@cavium.com>, David Rientjes <rientjes@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Daniel Vacek <neelx@redhat.com>, Roman Gushchin <guro@fb.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, linux-um@lists.infradead.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anton Altaparmakov <anton@tuxera.com>, linux-parisc@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Cyril Bur <cyrilbur@gmail.com>, =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, netfilter-devel@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, David Airlie <airlied@linux.ie>, dm-devel@redhat.com, Nadav Amit <namit@vmware.com>, Omar Sandoval <osandov@fb.com>, Alasdair Kergon <agk@redhat.com>, linux-s390@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, intel-gfx@lists.freedesktop.org, Helge Deller <deller@gmx.de>, Hugh Dickins <hughd@google.com>, "Luis R.
 Rodriguez" <mcgrof@kernel.org>, coreteam@netfilter.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-media@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, Todd Kjos <tkjos@android.com>, Philippe Ombredanne <pombredanne@nexb.com>, Jani Nikula <jani.nikula@linux.intel.com>, Jia He <jia.he@hxt-semitech.com>, Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>, Houlong Wei <houlong.wei@mediatek.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Martijn Coenen <maco@android.com>, linux-arm-kernel@lists.infradead.org, Khalid Aziz <khalid@gonehiking.org>, Oded Gabbay <oded.gabbay@gmail.com>, linaro-mm-sig@lists.linaro.org, linux-ntfs-dev@lists.sourceforge.net, Jonathan Corbet <corbet@lwn.net>, Florian Westphal <fw@strlen.de>, Anna Schumaker <anna.schumaker@netapp.com>, Pekka Enberg <penberg@kernel.org>, Minchan Kim <minchan@kernel.org>, Eric Biederman <ebiederm@xmission.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Kate Stewart <kstewart@linuxfoundation.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-fsdevel@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Agner <stefan@agner.ch>, James Morris <jmorris@namei.org>, netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org, Jan Kara <jack@suse.cz>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Gerrit Renker <gerrit@erg.abdn.ac.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Miklos Szeredi <miklos@szeredi.hu>, David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Matthew Auld <matthew.auld@intel.com>, Guo Ren <ren_guo@c-sky.com>, Huang Ying <ying.huang@intel.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ilya Dryomov <idryomov@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>, "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>, Mark Brown <broonie@kernel.org>, Borislav Petkov <bp@alien8.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dan Williams <dan.j.williams@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Dan Streetman <ddstreet@ieee.org>, Oscar Salvador <osalvador@suse.de>, linux-nfs@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>, Jeff Layton <jlayton@kernel.org>, Eric Dumazet <edumazet@google.com>, Jessica Yu <jeyu@kernel.org>, devel@linuxdriverproject.org, "David S. Miller" <davem@davemloft.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Minghsiu Tsai <minghsiu.tsai@mediatek.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "VMware, 
 Inc." <pv-drivers@vmware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Russell Currey <ruscur@russell.cc>, Chris Wilson <chris@chris-wilson.co.uk>, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, getarunks@gmail.com, Chintan Pandya <cpandya@codeaurora.org>, devel@driverdev.osuosl.org, "Yan,
 Zheng" <zyan@redhat.com>, xen-devel@lists.xenproject.org, Sage Weil <sage@redhat.com>, dccp@vger.kernel.org, Richard Weinberger <richard@nod.at>, Seth Jennings <sjenning@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Jeff Dike <jdike@addtoit.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Jann Horn <jannh@google.com>, Xavier Deguillard <xdeguillard@vmware.com>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?J=C3=A9r?= =?UTF-8?Q?=C3=B4me_Glisse?= <jglisse@redhat.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Tiffany Lin <tiffany.lin@mediatek.com>, linux-integrity@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Yang Shi <yang.shi@linux.alibaba.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, linuxppc-dev@lists.ozlabs.org, Vlad Yasevich <vyasevich@gmail.com>, linux-decnet-user@lists.sourceforge.net, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Mika Kuoppala <mika.kuoppala@linux.intel.com>, Mel Gorman <mgorman@techsingularity.net>

On 2018-10-23 09:45, Joe Perches wrote:
> On Mon, 2018-10-22 at 22:53 +0530, Arun KS wrote:
>> Remove managed_page_count_lock spinlock and instead use atomic
>> variables.
> 

Hello Joe,
> Perhaps better to define and use macros for the accesses
> instead of specific uses of atomic_long_<inc/dec/read>
> 
> Something like:
> 
> #define totalram_pages()	(unsigned 
> long)atomic_long_read(&_totalram_pages)
> #define totalram_pages_inc()	(unsigned 
> long)atomic_long_inc(&_totalram_pages)
> #define totalram_pages_dec()	(unsigned 
> long)atomic_long_dec(&_totalram_pages)

That sounds like a nice idea.

Regards,
Arun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
