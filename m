Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f204.google.com ([209.85.221.204])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1N5La6-00061k-8f
	for kexec@lists.infradead.org; Tue, 03 Nov 2009 15:46:06 +0000
Received: by qyk42 with SMTP id 42so3076792qyk.28
	for <kexec@lists.infradead.org>; Tue, 03 Nov 2009 07:46:00 -0800 (PST)
Message-ID: <4AF05047.5090403@gmail.com>
Date: Tue, 03 Nov 2009 16:46:15 +0100
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
Subject: Re: kdump fails to load and crashes [was: mmotm 2009-11-01-10-01
	uploaded]
References: <200911011807.nA1I7o95016136@imap1.linux-foundation.org>
	<4AEF673E.5030509@gmail.com> <20091103144450.GB4235@redhat.com>
	<4AF048D1.4090402@gmail.com> <20091103152448.GC4235@redhat.com>
In-Reply-To: <20091103152448.GC4235@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mm-commits@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>

On 11/03/2009 04:24 PM, Vivek Goyal wrote:
>> There /proc/iomem looks like:
>> 00100000-12beffff : System RAM
>>   01000000-04ffffff : Crash kernel
>>     01000000-014680c2 : Kernel code
>>     014680c3-016f39f7 : Kernel data
>>     0175b000-017d97ab : Kernel bss
...
> Anyway, can you just try reserving memory at some other address, say
> 64M@32M and see if it works.

Yup, that's it of course. I missed it overlaps with current kernel. I
though they are areas for the crash kernels. Thanks for pointing out. So
the error is we reserve the space for kdump even we can't in fact?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
