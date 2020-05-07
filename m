Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [RFC 34/43] shmem: PKRAM: multithread preserving and restoring
 shmem pages
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
 <1588812129-8596-35-git-send-email-anthony.yznaga@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4e44858d-a416-696e-0d65-0b5ca8836b7d@infradead.org>
Date: Thu, 7 May 2020 09:30:55 -0700
MIME-Version: 1.0
In-Reply-To: <1588812129-8596-35-git-send-email-anthony.yznaga@oracle.com>
Content-Language: en-US
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
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, mhocko@kernel.org, lei.l.li@intel.com, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, masahiroy@kernel.org, rafael.j.wysocki@intel.com, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, keescook@chromium.org, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, zhenzhong.duan@oracle.com, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, daniel.kiper@oracle.com

On 5/6/20 5:42 PM, Anthony Yznaga wrote:
> Improve performance by multithreading the work to preserve and restore
> shmem pages.
> 
> Add 'pkram_max_threads=' kernel option to specify the maximum number
> of threads to use to preserve or restore the pages of a shmem file.
> The default is 16.

Hi,
Please document kernel boot options in Documentation/admin-guide/kernel-parameters.txt.

> When preserving pages each thread saves chunks of a file to a pkram_obj
> until no more no more chunks are available.
> 
> When restoring pages each thread loads pages using a copy of a
> pkram_stream initialized by pkram_prepare_load_obj(). Under the hood
> each thread ends up fetching and operating on pkram_link pages.
> 
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  include/linux/pkram.h |   2 +
>  mm/shmem_pkram.c      | 101 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 101 insertions(+), 2 deletions(-)

thanks.
-- 
~Randy


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
