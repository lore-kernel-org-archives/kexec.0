Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hu7Nd-0003aZ-7T
	for kexec@lists.infradead.org; Fri, 01 Jun 2007 09:41:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [makedumpfile] config file -- OSRELEASE
References: <m1d50g3iwj.fsf@ebiederm.dsl.xmission.com>
	<20070601180704oomichi@mail.jp.nec.com>
	<20070601095228.GB27205@suse.de>
Date: Fri, 01 Jun 2007 07:40:34 -0600
In-Reply-To: <20070601095228.GB27205@suse.de> (Bernhard Walle's message of
	"Fri, 1 Jun 2007 11:52:28 +0200")
Message-ID: <m1myzj23ot.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: jlan@sgi.com, kexec@lists.infradead.org

Bernhard Walle <bwalle@suse.de> writes:

> * Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-06-01 11:07]:
>> 
>> Now, the items makedumpfile cannot get from vmlinux statically are
>> only version and page size. Do you have any idea for getting them
>> from vmlinux ?
>
> I already tried to address a similar issue (version + command line
> length for kexec-tools) by adding a ELF note. But it seems that kernel
> hackers didn't like it.
>
> http://article.gmane.org/gmane.comp.boot-loaders.fastboot.general/3996/.

I'm not seeing the discussion there.

Looking at the patch I'm not quite certain of the composition of your
notes. 

However as a general direction of using ELF notes I'm more or less
in favor of it.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
