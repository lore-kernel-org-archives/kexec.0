Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PPL4Y-00073r-JP
	for kexec@lists.infradead.org; Sun, 05 Dec 2010 20:20:39 +0000
Date: Sun, 5 Dec 2010 15:19:39 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kdump_post : busybox returns "Applet not found"
Message-ID: <20101205201938.GA2265@localhost.localdomain>
References: <4CF91748.5000401@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CF91748.5000401@hp.com>
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
To: Louis Bouchard <louis.bouchard@hp.com>
Cc: kexec@lists.infradead.org

On Fri, Dec 03, 2010 at 05:14:00PM +0100, Louis Bouchard wrote:
> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
> <html>
> <head>
> 
> <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
> </head>
> <body text="#000000" bgcolor="#ffffff">
> Hello (again)<br>
> <br>
> I did not think that I would come back to you so quickly, but I am
> having an issue with RHEL6 implementation of kexec-tools (apparently
> adapted for kexec-tools 2.0) while testing crashdc on RHEL6 (the
> initial release).<br>
> <br>
> Everytime I trigger a crash with 'kdump_post' set to
> /var/crash/scripts/kdump_post.sh I get the following from busybox :
> kdump-post.sh: applet not found<br>
> <br>
> <blockquote><tt>Copying data&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : [100%]</tt><br>
>   <tt>Saving core complete</tt><br>
>   <tt>kdump-post.sh: applet not found</tt><br>
>   <tt>dropping to initramfs shell</tt><br>
>   <tt>exiting this shell will reboot your system</tt><br>
> </blockquote>
> For a while, I thought that my crashdc calling script was in cause, but
> I changed kdump_post.sh to one single "echo This is working" line and I
> still get the same thing :<br>
> <br>
> <blockquote><tt># cat /var/crash/scripts/kdump-post.sh</tt><br>
>   <tt>echo "This is working"</tt><br>
>   <tt>/var/crash/scripts/kdump-post.sh</tt><br>
>   <tt>kdump-post.sh: applet not found</tt><br>
>   <tt>msh/ # /var/crash/scripts/kdump-post.sh</tt><br>
>   <tt>This is working</tt><br>
> </blockquote>
I'm kind of suprised this is working at all.  I don't see a #!/bin/sh or
#!/bin/msh line at the top of the script.  How does the system know what
interpreter to use?

Neil



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
