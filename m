Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7kkF-0006lv-4n
 for kexec@lists.infradead.org; Mon, 17 Aug 2020 19:24:36 +0000
Received: by mail-pg1-x543.google.com with SMTP id j21so8568094pgi.9
 for <kexec@lists.infradead.org>; Mon, 17 Aug 2020 12:24:32 -0700 (PDT)
Date: Mon, 17 Aug 2020 12:24:29 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH RFC 2/2] lkdtm: Add heap spraying test
Message-ID: <202008171222.3F206231E@keescook>
References: <20200813151922.1093791-1-alex.popov@linux.com>
 <20200813151922.1093791-3-alex.popov@linux.com>
 <87zh6t9llm.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zh6t9llm.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kernel-hardening@lists.openwall.com, Peter Zijlstra <peterz@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>, Pekka Enberg <penberg@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Rientjes <rientjes@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Laura Abbott <labbott@redhat.com>, Alexander Popov <alex.popov@linux.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Dmitry Vyukov <dvyukov@google.com>, notify@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Patrick Bellasi <patrick.bellasi@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Aug 17, 2020 at 01:24:37PM -0500, Eric W. Biederman wrote:
> Alexander Popov <alex.popov@linux.com> writes:
> 
> > Add a simple test for CONFIG_SLAB_QUARANTINE.
> >
> > It performs heap spraying that aims to reallocate the recently freed heap
> > object. This technique is used for exploiting use-after-free
> > vulnerabilities in the kernel code.
> >
> > This test shows that CONFIG_SLAB_QUARANTINE breaks heap spraying
> > exploitation technique.
> >
> > Signed-off-by: Alexander Popov <alex.popov@linux.com>
> 
> Why put this test in the linux kernel dump test module?
> 
> I have no problem with tests, and I may be wrong but this
> does not look like you are testing to see if heap corruption
> triggers a crash dump.  Which is what the rest of the tests
> in lkdtm are about.  Seeing if the test triggers successfully
> triggers a crash dump.

The scope of LKDTM has shifted a bit, and I'm fine with tests that
don't cause crashes as long as they're part of testing system-wide
defenses, etc. It's easier to collect similar tests together (even if
they don't break the system).

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
