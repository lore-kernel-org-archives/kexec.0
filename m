Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcPZ2-0000VC-BI
 for kexec@lists.infradead.org; Thu, 17 Sep 2015 03:08:49 +0000
Received: by pacex6 with SMTP id ex6so6966594pac.0
 for <kexec@lists.infradead.org>; Wed, 16 Sep 2015 20:08:27 -0700 (PDT)
Message-ID: <55fa2eaa.ca39440a.feaa1.36f5@mx.google.com>
Date: Wed, 16 Sep 2015 20:08:26 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 11/13] Always define MAX_RAW_MINORS as 65535 in userspace
In-Reply-To: <55F882C7.4080304@zytor.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: hpa@zytor.com
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, dhowells@redhat.com, jcmvbkbc@gmail.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, plagnioj@jcrosoft.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, a.p.zijlstra@chello.nl, arnd@arndb.de, jikos@kernel.org, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

On Tue, 15 Sep 2015 13:42:47 PDT (-0700), hpa@zytor.com wrote:
> On 09/14/2015 03:50 PM, Palmer Dabbelt wrote:
>> While I don't think this was ever meant to be exposed to userspace, if
>> anyone is using it then this will at least provide a correct (if
>> unlikely) definition.
>>
>> MAX_RAW_MINORS used to be used in the kernel, where it's been replaced
>> with CONFIG_MAX_RAW_MINORS.
>>
>> Note that there's a checkpatch.pl warning about a split config string
>> here, but I've left that alone.
>
> From a UAPI perspective I would think the right value would be 2^20.

Wow, I'm super surprised.  For some reason I thought major/minor
numbers were 16 bits, but according to glibc I just have no idea what
I'm doing :).

Thanks for catching this!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
