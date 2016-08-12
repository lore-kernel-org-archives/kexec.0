Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bY0k4-00081Z-Qt
 for kexec@lists.infradead.org; Fri, 12 Aug 2016 00:54:33 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7C0rulb104561
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 20:54:12 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9v1rwa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 20:54:11 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 21:54:09 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 44ACA1DC006F
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 20:53:57 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7C0s6fL4427978
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 21:54:06 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7C0s5c3004844
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 21:54:06 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 11/13] powerpc: Allow userspace to set device tree
 properties in kexec_file_load
Date: Thu, 11 Aug 2016 21:54:02 -0300
In-Reply-To: <1470962700.2570.6.camel@mendozajonas.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956898-5991-12-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470962700.2570.6.camel@mendozajonas.com>
MIME-Version: 1.0
Message-Id: <1516604.QKHlMVtQ9l@hactar>
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
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Hello Sam,

Thanks for the quick response.

Am Freitag, 12 August 2016, 10:45:00 schrieb Samuel Mendoza-Jonas:
> On Thu, 2016-08-11 at 20:08 -0300, Thiago Jung Bauermann wrote:
> > @@ -908,4 +909,245 @@ bool find_debug_console(const void *fdt, int
> > chosen_node) return false;
> >  }
> >  
> > +/**
> > + * struct allowed_node - a node in the whitelist and its allowed
> > properties. + * @name:              node name or full node path
> > + * @properties:                NULL-terminated array of names or
> > name=value pairs + *
> > + * If name starts with /, then the node has to be at the specified path
> > in + * the device tree (including unit addresses for all nodes in the
> > path). + * If it doesn't, then the node can be anywhere in the device
> > tree. + *
> > + * An entry in properties can specify a string value that the property
> > must + * have by using the "name=value" format. If the entry ends with
> > =, it means + * that the property must be empty.
> > + */
> > +static struct allowed_node {
> > +       const char *name;
> > +       const char *properties[9];
> > +} allowed_nodes[] = {
> > +       {
> > +               .name = "/chosen",
> > +               .properties = {
> > +                       "stdout-path",
> > +                       "linux,stdout-path",
> > +                       NULL,
> > +               }
> > +       },
> > +       {
> > +               .name = "vga",
> > +               .properties = {
> > +                       "device_type=display",
> > +                       "assigned-addresses",
> > +                       "width",
> > +                       "height",
> > +                       "depth",
> > +                       "little-endian=",
> > +                       "linux,opened=",
> > +                       "linux,boot-display=",ss
> > +                       NULL,
> > +               }
> > +       },
> > +};
> 
> Hi Thiago,
> 
> As much as this solves problems for *me*, I suspect adding 'vga' here
> might be the subject of some discussion. Having /chosen whitelisted makes
> sense on it's own, but 'vga' and its properties are very specific without
> much explanation.
> 
> If everyone's happy to have it there, cool! If not, I have the majority
> of a patch that handles the original reason for these property updates
> separately in the kernel rather than from userspace. If needed I'll clean
> it up and we can handle it that way.

Ok, that's good to know. I'm fine with it either way. In any case, 'vga' in 
this patch also serves a good real-life example of a non-trivial binding 
outside of /chosen that we might want to whitelist in the future.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
