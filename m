Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvSBT-0005Dx-Vv
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 07:43:12 +0000
Message-ID: <49096597.1030800@redhat.com>
Date: Thu, 30 Oct 2008 09:43:19 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
References: <m1tzb2hkny.fsf@frodo.ebiederm.org>
	<4904676F.3020706@redhat.com>	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com>	<20081026213927.GF23893@blackpad>
	<m1bpx6bxhm.fsf@frodo.ebiederm.org>	<49058645.9010005@redhat.com>
	<20081027122808.GH23893@blackpad>	<4905C9ED.807@redhat.com>
	<m18wsa7xl0.fsf@frodo.ebiederm.org>	<20081028194530.GK23893@blackpad>
	<m18ws84gxc.fsf@frodo.ebiederm.org>	<49082FD0.3040009@redhat.com>
	<m13aif4fk7.fsf@frodo.ebiederm.org>	<4908975A.7050900@redhat.com>
	<m1bpx23lzg.fsf@frodo.ebiederm.org> <490963DF.90703@redhat.com>
In-Reply-To: <490963DF.90703@redhat.com>
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
To: Chris Lalancette <clalance@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Chris Lalancette wrote:
> I'm pretty sure you have to test for it first; pre-64 bit x86 hardware doesn't
> have the EFER register, so you'll fault on access.  On the other hand pre-64 bit
> x86 hardware doesn't usually (ever?) have VT extensions either.
>   

All amd hardware that supports svm has an efer.  Some Intel hardware 
doesn't, but we don't care in that case.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
