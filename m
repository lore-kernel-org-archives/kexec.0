Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvCbK-0000IH-Uh
	for kexec@lists.infradead.org; Wed, 29 Oct 2008 15:04:51 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org> <490487C1.1010707@redhat.com>
	<20081026213927.GF23893@blackpad>
	<m1bpx6bxhm.fsf@frodo.ebiederm.org>
	<49058645.9010005@redhat.com> <20081027122808.GH23893@blackpad>
	<4905C9ED.807@redhat.com> <m18wsa7xl0.fsf@frodo.ebiederm.org>
	<20081028194530.GK23893@blackpad> <m18ws84gxc.fsf@frodo.ebiederm.org>
	<49082FD0.3040009@redhat.com>
Date: Wed, 29 Oct 2008 07:54:48 -0700
In-Reply-To: <49082FD0.3040009@redhat.com> (Avi Kivity's message of "Wed, 29
	Oct 2008 11:41:36 +0200")
Message-ID: <m13aif4fk7.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>

Avi Kivity <avi@redhat.com> writes:

> Eric W. Biederman wrote:
>>> I think I will get flamed if I try to pull to the core a bunch of code
>>> that always lived in the KVM module.  8)
>>>
>>
>> Why is KVM modular anyway?  That seems like some pretty core cpu
> functionality...
>>
>
> Many reasons.  Developers like the ability to rmmod and modprobe during
> development.  Distros like to keep their non-modular core small.  There is an
> external module distribution that allows users to graft a new kvm on an old
> kernel, which our testers and bleeding edge users like.  Because it's there.

Most of the reason I was wondering is that the cpu hardware probing
largely seems to be a duplicate of what we have in the core for
probing cpu capabilities already, and could likely be made smaller
by building upon the existing codebase.


> svm can writeback into memory at odd times if we don't do this, and the cost is
> small - clear a bit in EFER.  There's no reason to be lazy.

Especially if we can clear that bit unconditionally (when
EFER is present) I'm all for it.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
