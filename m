Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWkgJ-0003Zx-G0
 for kexec@lists.infradead.org; Thu, 07 May 2020 17:51:37 +0000
Received: by mail-pf1-x442.google.com with SMTP id 18so3350196pfx.6
 for <kexec@lists.infradead.org>; Thu, 07 May 2020 10:51:34 -0700 (PDT)
Date: Thu, 7 May 2020 10:51:32 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC 21/43] x86/KASLR: PKRAM: support physical kaslr
Message-ID: <202005071049.2D0939137D@keescook>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
 <1588812129-8596-22-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1588812129-8596-22-git-send-email-anthony.yznaga@oracle.com>
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
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, zhenzhong.duan@oracle.com, lei.l.li@intel.com, linux-mm@kvack.org, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, daniel.kiper@oracle.com, x86@kernel.org, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mhocko@kernel.org, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, linux-kernel@vger.kernel.org, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, masahiroy@kernel.org

On Wed, May 06, 2020 at 05:41:47PM -0700, Anthony Yznaga wrote:
> Avoid regions of memory that contain preserved pages when computing
> slots used to select where to put the decompressed kernel.

This is changing the slot-walking code instead of updating
mem_avoid_overlap() -- that's where the check for a "reserved" memory
area should live.

For example, this is how both mem_avoid_memmap() and the setup_data
memory areas are handled.

Is there a reason mem_avoid_overlap() can't be used here?

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
