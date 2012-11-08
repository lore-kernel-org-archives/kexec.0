Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e39.co.us.ibm.com ([32.97.110.160])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWZ03-0003Xu-AX
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 20:46:56 +0000
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 8 Nov 2012 13:46:52 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 9CE113E4003F
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 13:46:48 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA8KkhZO180494
 for <kexec@lists.infradead.org>; Thu, 8 Nov 2012 13:46:48 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA8Kkdwt020674
 for <kexec@lists.infradead.org>; Thu, 8 Nov 2012 13:46:39 -0700
Message-ID: <1352407597.30800.92.camel@falcor.watson.ibm.com>
Subject: Re: Kdump with signed images
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 08 Nov 2012 15:46:37 -0500
In-Reply-To: <20121108194050.GB27586@redhat.com>
References: <20121101135356.GA15659@redhat.com>
 <1351780159.15708.17.camel@falcor> <20121101144304.GA15821@redhat.com>
 <20121101145225.GB10269@srcf.ucam.org> <20121102132318.GA3300@redhat.com>
 <87boffd727.fsf@xmission.com> <20121105180353.GC28720@redhat.com>
 <87mwyv96mn.fsf@xmission.com> <20121106193419.GH4548@redhat.com>
 <87k3tynvc0.fsf@xmission.com> <20121108194050.GB27586@redhat.com>
Mime-Version: 1.0
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
Cc: Roberto Sassu <roberto.sassu@polito.it>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, Peter Jones <pjones@redhat.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Thu, 2012-11-08 at 14:40 -0500, Vivek Goyal wrote:
> On Tue, Nov 06, 2012 at 03:51:59PM -0800, Eric W. Biederman wrote:
> 
> [..]
> 
> Thnking more about executable signature verification, I have another question.
> 
> While verifyign the signature, we will have to read the whole executable
> in memory. That sounds bad as we are in kernel mode and will not be killed
> and if sombody is trying to execute a malformed exceptionally large
> executable, system will start killing other processess. We can potentially
> lock all the memory in kernel just by trying to execute a signed huge
> executable. Not good.
> 
> I was looking at IMA and they seem to be using kernel_read() for reading
> page in and update digest. IIUC, that means page is read from disk,
> brought in cache and if needed will be read back from disk. But that
> means hacker can try to do some timing tricks and try to replace disk image
> after signature verification and run unsigned program.

For the reason you mentioned, the signature verification is deferred to
bprm, after the executable has been locked from modification.  Any
subsequent changes to the file would cause the file to be re-appraised.

The goal of EVM/IMA-appraisal is to detect file tampering and enforce
file data/metadata integrity.  If EVM/IMA-appraisal fail, then as a last
resort, we fall back and rely on IMA measurement/attestation at least to
detect it.

Mimi

> So how do we go about it. Neither of the approaches sound appealing
> to me.
> 
> Thanks
> Vivek




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
