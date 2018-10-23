Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <20181022181122.GK18839@dhcp22.suse.cz>
In-Reply-To: <20181022181122.GK18839@dhcp22.suse.cz>
From: Arun Sudhilal <getarunks@gmail.com>
Date: Tue, 23 Oct 2018 10:16:51 +0530
Message-ID: <CABOM9Zpq41Ox8wQvsNjgfCtwuqh6CnyeW1B09DWa1TQN+JKf0w@mail.gmail.com>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
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
To: mhocko@kernel.org
Cc: snitzer@redhat.com, benh@kernel.crashing.org, kemi.wang@intel.com, dri-devel@lists.freedesktop.org, bfields@fieldses.org, linux-sctp@vger.kernel.org, paulus@samba.org, pavel@ucw.cz, cl@linux.com, kys@microsoft.com, sumit.semwal@linaro.org, David1.Zhou@amd.com, ptesarik@suse.com, mpe@ellerman.id.au, ceph-devel@vger.kernel.org, jejb@parisc-linux.org, kasan-dev@googlegroups.com, marcos.souza.org@gmail.com, steven.hill@cavium.com, rientjes@google.com, anthony.yznaga@oracle.com, neelx@redhat.com, guro@fb.com, len.brown@intel.com, linux-pm@vger.kernel.org, vbabka@suse.cz, linux-um@lists.infradead.org, rppt@linux.vnet.ibm.com, viro@zeniv.linux.org.uk, tglx@linutronix.de, trond.myklebust@hammerspace.com, anton@tuxera.com, linux-parisc@vger.kernel.org, malat@debian.org, gregkh@linuxfoundation.org, rdunlap@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, cyrilbur@gmail.com, arve@android.com, netfilter-devel@vger.kernel.org, jrdr.linux@gmail.com, dmitry.kasatkin@gmail.com, alexander.deucher@amd.com, arunks@codeaurora.org, Andrew Morton <akpm@linux-foundation.org>, andrew-ct.chen@mediatek.com, gustavo@embeddedor.com, airlied@linux.ie, dm-devel@redhat.com, namit@vmware.com, osandov@fb.com, agk@redhat.com, linux-s390@vger.kernel.org, sthemmin@microsoft.com, intel-gfx@lists.freedesktop.org, deller@gmx.de, hughd@google.com, mcgrof@kernel.org, coreteam@netfilter.org, kadlec@blackhole.kfki.hu, aryabinin@virtuozzo.com, linux-media@vger.kernel.org, yuehaibing@huawei.com, tkjos@android.com, pombredanne@nexb.com, jani.nikula@linux.intel.com, jia.he@hxt-semitech.com, Tejun Heo <tj@kernel.org>, shakeelb@google.com, houlong.wei@mediatek.com, devel@linuxdriverproject.org, boris.ostrovsky@oracle.com, maco@android.com, linux-arm-kernel@lists.infradead.org, khalid@gonehiking.org, oded.gabbay@gmail.com, linaro-mm-sig@lists.linaro.org, linux-ntfs-dev@lists.sourceforge.net, corbet@lwn.net, fw@strlen.de, anna.schumaker@netapp.com, penberg@kernel.org, minchan@kernel.org, ebiederm@xmission.com, aneesh.kumar@linux.ibm.com, schwidefsky@de.ibm.com, iamjoonsoo.kim@lge.com, kstewart@linuxfoundation.org, marcelo.leitner@gmail.com, linux-fsdevel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, stefan@agner.ch, jmorris@namei.org, netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org, jack@suse.cz, alexander.h.duyck@linux.intel.com, gerrit@erg.abdn.ac.uk, andriy.shevchenko@linux.intel.com, miklos@szeredi.hu, david@redhat.com, willy@infradead.org, khlebnikov@yandex-team.ru, matthew.auld@intel.com, ren_guo@c-sky.com, ying.huang@intel.com, kuznet@ms2.inr.ac.ru, idryomov@gmail.com, adobriyan@gmail.com, pablo@netfilter.org, serge@hallyn.com, keescook@chromium.org, arnd@arndb.de, haiyangz@microsoft.com, broonie@kernel.org, bp@alien8.de, rodrigo.vivi@intel.com, dan.j.williams@intel.com, mchehab@kernel.org, ddstreet@ieee.org, osalvador@suse.de, linux-nfs@vger.kernel.org, nhorman@tuxdriver.com, tvrtko.ursulin@intel.com, jlayton@kernel.org, edumazet@google.com, jeyu@kernel.org, joe@perches.com, davem@davemloft.net, kirill.shutemov@linux.intel.com, minghsiu.tsai@mediatek.com, christian.koenig@amd.com, pv-drivers@vmware.com, bigeasy@linutronix.de, ruscur@russell.cc, chris@chris-wilson.co.uk, linux-mm@kvack.org, glider@google.com, hpa@zytor.com, cpandya@codeaurora.org, devel@driverdev.osuosl.org, zyan@redhat.com, xen-devel@lists.xenproject.org, sage@redhat.com, dccp@vger.kernel.org, richard@nod.at, sjenning@redhat.com, x86@kernel.org, mingo@redhat.com, labbott@redhat.com, zohar@linux.vnet.ibm.com, jdike@addtoit.com, pavel.tatashin@microsoft.com, jannh@google.com, xdeguillard@vmware.com, hannes@cmpxchg.org, jglisse@redhat.com, ktkhai@virtuozzo.com, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, tiffany.lin@mediatek.com, linux-integrity@vger.kernel.org, dvyukov@google.com, jgross@suse.com, yang.shi@linux.alibaba.com, yoshfuji@linux-ipv6.org, linuxppc-dev@lists.ozlabs.org, vyasevich@gmail.com, linux-decnet-user@lists.sourceforge.net, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, tzimmermann@suse.de, mika.kuoppala@linux.intel.com, mgorman@techsingularity.net

On Mon, Oct 22, 2018 at 11:41 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 22-10-18 22:53:22, Arun KS wrote:
> > Remove managed_page_count_lock spinlock and instead use atomic
> > variables.
>

Hello Michal,
> I assume this has been auto-generated. If yes, it would be better to
> mention the script so that people can review it and regenerate for
> comparision. Such a large change is hard to review manually.

Changes were made partially with script.  For totalram_pages and
totalhigh_pages,

find dir -type f -exec sed -i
's/totalram_pages/atomic_long_read(\&totalram_pages)/g' {} \;
find dir -type f -exec sed -i
's/totalhigh_pages/atomic_long_read(\&totalhigh_pages)/g' {} \;

For managed_pages it was mostly manual edits after using,
find mm/ -type f -exec sed -i
's/zone->managed_pages/atomic_long_read(\&zone->managed_pages)/g' {}
\;

Regards,
Arun

> --
> Michal Hocko
> SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
