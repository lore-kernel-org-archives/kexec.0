Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wf-out-1314.google.com ([209.85.200.175])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KqYh0-0000wB-6u
	for kexec@lists.infradead.org; Thu, 16 Oct 2008 19:39:30 +0000
Received: by wf-out-1314.google.com with SMTP id 28so150927wfc.24
	for <kexec@lists.infradead.org>; Thu, 16 Oct 2008 12:39:29 -0700 (PDT)
Message-ID: <ba7d8f720810161239u46c7823qe99b2f96643ea801@mail.gmail.com>
Date: Thu, 16 Oct 2008 15:39:28 -0400
From: "Dan Upton" <upton.dan.linux@gmail.com>
Subject: Re: kexec on x86_64: entry32_regs not found cannot get
In-Reply-To: <20081016200932.47906dcd@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
References: <ba7d8f720810161047p7d003901g35f969404fa77b0f@mail.gmail.com>
	<20081016200932.47906dcd@kopernikus.site>
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
To: kexec@lists.infradead.org

On Thu, Oct 16, 2008 at 2:09 PM, Bernhard Walle <bwalle@suse.de> wrote:
> * "Dan Upton" <upton.dan.linux@gmail.com> [2008-10-16 13:47]:
>>
>> I'm trying to use kexec to help debug some scheduler work I'm doing,
>> but I can't seem to get kexec to load the kernel.  I'm using
>> kexec-tols-testing-20080227.
>
> Why don't you try 2.0.0 first?
>
>
> Regards,
> Bernhard
> --
> Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

Sure enough, that worked.  Sorry, I didn't realize there was a newer
version--the kernel doc had a link that it said should always be a
symbolic link to the most recent version, and I didn't think to look
in the directory to make sure that was the case.

-dan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
