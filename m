From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 May 2007 21:06:35 +1000
Subject: [Patch ] Kexec/Kdump support - POWER6
In-Reply-To: <1180433684.5953.1.camel@concordia.ozlabs.ibm.com>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com>
	<20070524142133.GA13191@lixom.net> <4656A488.2020507@in.ibm.com>
	<1180132987.19517.9.camel@localhost.localdomain>
	<465ABFC9.9020502@in.ibm.com>
	<1180433684.5953.1.camel@concordia.ozlabs.ibm.com>
Message-ID: <20070529210635.0e840545.sfr@canb.auug.org.au>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, 29 May 2007 20:14:44 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:
>
> Add this to your ~/.vimrc, you do use vim right :)
>
> highlight RedundantWhitespace ctermbg=red guibg=red

You need this as well:

match RedundantWhitespace /\s\+$\| \+\ze\t/

--
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.infradead.org/pipermail/kexec/attachments/20070529/85b1ef30/attachment.bin 
