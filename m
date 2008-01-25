Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JIQn3-00012f-W8
	for kexec@lists.infradead.org; Fri, 25 Jan 2008 15:48:33 +0000
Message-ID: <479A03DD.5030308@zytor.com>
Date: Fri, 25 Jan 2008 07:44:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: Kexec command line length
References: <20080114134303.GA947@hmsreliant.think-freely.org>
	<20080115152710.GA24435@redhat.com>
	<20080115170950.GA24359@hmsendeavour.rdu.redhat.com>
	<20080115173753.GB24435@redhat.com>
	<20080125123558.GA5627@hmsreliant.think-freely.org>
	<20080125153924.GA13287@redhat.com>
In-Reply-To: <20080125153924.GA13287@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Neil Horman <nhorman@tuxdriver.com>

Vivek Goyal wrote:
> Hi Neil,
> 
> I had a closer look at the code and following are my thoughts.
> 
> If I look at the 2.6.24 x86 boot code, I think this code does not expect a
> boot loader to put 2048 size command line in 4K page (so called zero page).
> I think what it expects is that a boot loader puts command line somewhere
> outside the zero page and just pass the pointer to that command line in zero
> page.

No, and it never has to the best of my knowledge.

> So far kexec has been putting command line in zero page. I think it worked
> because command line was small (256) and zero page had lots of free
> reserved area. (E820MAX was 32). 
> 
> Now in latest kernel code E820MAX has been increased to 128 and I don't see
> lot of free space in bootparam where we can put the 2048 size command line.
> 
> If we just continue to do what we are doing and just extend the command
> line size to 2048 in kexec-tools, i think this will overlap with some other
> area, either with EDD or E820 map etc and real mode code will overwrite part
> of command line as passed by kexec, on some systems.
> 
> So I think we should modify kexec-tools and start putting the 2048
> size command line outside the setup/zero page.
> 
> CCing HPA and Eric. They should be able to guide us better.

You should put it outside struct bootparams.  Furthermore, you should 
expect an increasing amount of information to be needed beyond struct 
bootparams in the future; the intent is to have a tagged linked list of 
expansion information in the future.

We are already out of e820 *and* EDD information space...

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
