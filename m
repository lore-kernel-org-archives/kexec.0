Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TWY2g-0003uB-U9
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 19:45:35 +0000
Date: Thu, 8 Nov 2012 14:45:22 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kdump with signed images
Message-ID: <20121108194522.GC27586@redhat.com>
References: <1351780159.15708.17.camel@falcor>
 <20121101144304.GA15821@redhat.com>
 <20121101145225.GB10269@srcf.ucam.org>
 <20121102132318.GA3300@redhat.com> <87boffd727.fsf@xmission.com>
 <20121105180353.GC28720@redhat.com> <87mwyv96mn.fsf@xmission.com>
 <20121106193419.GH4548@redhat.com> <87k3tynvc0.fsf@xmission.com>
 <20121108194050.GB27586@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121108194050.GB27586@redhat.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roberto Sassu <roberto.sassu@polito.it>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, Peter Jones <pjones@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Thu, Nov 08, 2012 at 02:40:50PM -0500, Vivek Goyal wrote:
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

Also, even if we try to read in whole executable, can't an hacker modify
pages in swap disk and then they will be faulted back in and bingo hacker
is running its unsigned code. (assuming root has been compromised otherwise
why do we have to do all this exercise).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
