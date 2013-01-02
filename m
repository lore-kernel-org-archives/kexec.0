Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TqMnd-0002nR-Bb
 for kexec@lists.infradead.org; Wed, 02 Jan 2013 11:47:58 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <50DBC856.6030208@zytor.com>
 <791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
 <50DC58C4.3000307@citrix.com> <874nj7qsor.fsf@xmission.com>
 <50E41973.9050705@citrix.com>
Date: Wed, 02 Jan 2013 03:47:28 -0800
In-Reply-To: <50E41973.9050705@citrix.com> (Andrew Cooper's message of "Wed, 2
 Jan 2013 11:26:43 +0000")
Message-ID: <87r4m3yffz.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
 implementation
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
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

Andrew Cooper <andrew.cooper3@citrix.com> writes:

> On 27/12/12 18:02, Eric W. Biederman wrote:
>> Andrew Cooper<andrew.cooper3@citrix.com>  writes:
>>
>>> On 27/12/2012 07:53, Eric W. Biederman wrote:
>>>> The syscall ABI still has the wrong semantics.
>>>>
>>>> Aka totally unmaintainable and umergeable.
>>>>
>>>> The concept of domU support is also strange.  What does domU support even mean, when the dom0 support is loading a kernel to pick up Xen when Xen falls over.
>>> There are two requirements pulling at this patch series, but I agree
>>> that we need to clarify them.
>> It probably make sense to split them apart a little even.
>>
>>
>
> Thinking about this split, there might be a way to simply it even more.
>
> /sbin/kexec can load the "Xen" crash kernel itself by issuing
> hypercalls using /dev/xen/privcmd.  This would remove the need for the
> dom0 kernel to distinguish between loading a crash kernel for itself
> and loading a kernel for Xen.
>
> Or is this just a silly idea complicating the matter?

At a first approximation it sounds reasonable.

If the Xen kexec actually copies the loaded kernel to somewhere internal
like the linux kexec that would be entirely reasonable.  If Xen has
other requirements on the dom0 case you might not be able to implement
the call without linux kernel support.

But if you can implement it all in terms of /dev/xen/privcmd go for it.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
