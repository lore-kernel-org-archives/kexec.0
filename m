Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aDNF8-0003Bp-JV
 for kexec@lists.infradead.org; Mon, 28 Dec 2015 02:09:03 +0000
Date: Mon, 28 Dec 2015 10:08:29 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [Linux-ima-devel] [PATCH v2 4/7] ima: measure and appraise kexec
 image and initramfs
Message-ID: <20151228020829.GB2980@dhcp-128-65.nay.redhat.com>
References: <1450914903-5793-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1450914903-5793-5-git-send-email-zohar@linux.vnet.ibm.com>
 <20151225053356.GA3398@dhcp-128-65.nay.redhat.com>
 <1451054749.3289.131.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1451054749.3289.131.camel@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, David Woodhouse <dwmw2@infradead.org>, Vivek Goyal <vgoyal@redhat.com>

Hi, Mimi

On 12/25/15 at 09:45am, Mimi Zohar wrote:
> On Fri, 2015-12-25 at 13:33 +0800, Dave Young wrote:
> > Hi, Mimi
> > 
> > CCing kexec list, not all kexec people subscribed to IMA list.
> > I just subscribed to it since Vivek CCed me last time about the V1 of this
> > series.
> 
> Thanks!
> 
> > On 12/23/15 at 06:55pm, Mimi Zohar wrote:
> > > This patch defines a new IMA hook ima_hash_and_process_file() for
> > > measuring and appraising files read by the kernel.  The caller loads
> > > the file into memory before calling this function, which calculates
> > > the hash followed by the normal IMA policy based processing.
> > > 
> > > Two new IMA policy functions named KEXEC_CHECK and INITRAMFS_CHECK
> > > are defined for measuring, appraising or auditing the kexec image
> > > and initramfs.
> > 
> > Could you help us understand why do we need it first.
> 
> IMA can be viewed as extending secure and trusted boot to the running
> system in a uniform and consistent manner.   As files are accessed,
> based on policy, IMA measures them, appends the file measurements to the
> running measurement list (<securityfs>/ima/ascii_runtime_measurements)
> and appraises the file's integrity, based on either the file's hash or
> signature, which are stored as extended attributes in "security.ima".
> 
> There are still a couple of file measurement and appraisal gaps that
> need to be closed.
> 
> > I think I do not really understand the purpose of the IMA handling
> > about kexec kernel and initramfs.
> 
> One of those measurement and appraisal gaps are files that are read by
> the kernel, like the kexec image and initramfs.
> 
> [There is a lot of code duplication in the kernel for reading a file and
> verifying its signature.   Each place does it just a bit differently
> than the other.  I'm working with Luis Rodriguez on defining a single,
> common function  - https://lkml.org/lkml/2015/12/21/478.]
> 
> > * Does the files in disk space have already contains some hash values 
> > and when kernel load it IMA functions will do some checking? But seems I do not
> > see such handling..
> 
> IMA sits on a number of the LSM hooks, where they exist, and in other
> places defines its own hook.   This patch set defines a new IMA hook for
> measuring and appraising files being read by the kernel.
> 
> > * Does it try to calculate the hash of the file buffer after copying,
> 
> IMA calculates the file hash, in this case, based on the buffer
> contents.   The hash is calculated once and used for both measurement
> and appraisal.  If the file integrity appraisal fails (eg. hash
> comparison or signature failure), IMA prevents the kexec files from
> being used.
> 

Ok, thanks for the explanatioin. But I have another question, why do we
need a special hook for KEXEC? Shouldn't all files use same way to do the
measurement and appraisal?

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
