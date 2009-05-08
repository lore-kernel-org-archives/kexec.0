Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1M2X4b-0004a5-QA
	for kexec@lists.infradead.org; Fri, 08 May 2009 20:53:46 +0000
Message-ID: <4A049AF5.7090300@zytor.com>
Date: Fri, 08 May 2009 13:49:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 05/14] kbuild: allow compressors (gzip, bzip2, lzma) to
	take multiple inputs
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-6-git-send-email-hpa@linux.intel.com>
	<20090508074234.GD12808@uranus.ravnborg.org>
	<4A0493B0.3090204@linux.intel.com>
	<20090508204747.GA18041@uranus.ravnborg.org>
In-Reply-To: <20090508204747.GA18041@uranus.ravnborg.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, "H. Peter Anvin" <hpa@linux.intel.com>, tglx@linutronix.de, vgoyal@redhat.com

Sam Ravnborg wrote:
> 
> I did a quick attempt to integrate it in the Makefile - not pretty.
> So I dropped that idea.
> 
> It is mainly that we should not fill up scripts/ with small
> undocumented scripts.
> 
> Could you add something like this in the top of the file:
> 
> # Find the sum of the size of all files specified and
> # output the size as an escaped hex string.
> #
> # Sample:
> # $ ls -l foo
> # $ -rw-rw-r-- 1 xxx xxx 146 May  8 22:28 foo
> # $ bin_size foo
> # $ \\x92\\x00\\x00\\x00
> # 146 equals 92 hex
> 

OK, I see your point (especially since that's not what it does.)

To be honest, how ugly would it be to get a C program in here?  Doing 
this in shell is horrid, and people tend to whine about Perl (which is 
perfect for this kind of job.)

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
