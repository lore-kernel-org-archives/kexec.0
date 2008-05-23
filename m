Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JzgR6-0002yE-Ka
	for kexec@lists.infradead.org; Fri, 23 May 2008 23:12:34 +0000
Date: Sat, 24 May 2008 09:12:24 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC] Win32 port of the userspace tools using MinGW.
Message-ID: <20080523231223.GD4517@verge.net.au>
References: <20080516054813.GA21670@oh.minilop.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080516054813.GA21670@oh.minilop.net>
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
To: Jamey Sharp <jamey@thetovacompany.com>
Cc: kexec@lists.infradead.org

On Thu, May 15, 2008 at 10:48:13PM -0700, Jamey Sharp wrote:
> OK, I haven't quite gotten around to posting the Windows kernel driver
> source that goes with this. So I'm not asking that this patch be merged,
> since nobody else can use it yet. :-) I'd love to get review, though:
> Does this look like it's in a mergeable state? I'm happy with it, but do
> I need to change anything to make it acceptable to you folks?
> 
> This patch requires basically all the other patches I've posted.

Hi Jamey,

Firstly, thanks for your work in not only getting this port up and going,
but methodically posted patches relating to it. You have made my job
very easy :-)

The patch looks a little invasive, but I guess that is to be expected
given the nature of what you re doing. I wonder if there will be other
equally different ports (by which I mean its the first time the code has
been made to work outside of some Linux environment) and thus whether it
is worth abstracting some of these things somehow. Just a thought. I'm
not opposed to the patch as it is.

Can you advise if there is any way to cross compile this code on a Linux
(i686) box? Its not critical, I'm more curious than anything else. But
if it is possible, it would at least allow me to check that the code
still compiles as other changes get merged in over time.

The licence in include/byteswap.h.  How does that effect the licencing
of the rest of the code?  Is it going to cause any distributions - I am
thinking about Debian - to have a cow?

Lastly, I'm a big fan of <= 80 character wide lines.

-- 
Horms

>  Makefile.in                       |    1 +
>  include/byteswap.h                |   39 +++++++
>  kexec/Makefile                    |    6 +
>  kexec/arch/i386/Makefile          |    2 +
>  kexec/arch/i386/kexec-x86.c       |    2 +
>  kexec/arch/i386/x86-linux-setup.c |    4 +
>  kexec/kexec-syscall.h             |    7 ++
>  kexec/kexec.c                     |    4 +
>  kexec/kexec.h                     |   10 ++
>  kexec/win32.c                     |  214 +++++++++++++++++++++++++++++++++++++
>  10 files changed, 289 insertions(+), 0 deletions(-)
>  create mode 100644 include/byteswap.h
>  create mode 100644 kexec/win32.c
> 
> diff --git a/Makefile.in b/Makefile.in
> index b51c3a1..bdd6ba7 100644
> --- a/Makefile.in
> +++ b/Makefile.in
> @@ -24,6 +24,7 @@ ARCH		= @ARCH@
>  OBJDIR		= @OBJDIR@
>  target		= @target@
>  host		= @host@
> +host_os		= @host_os@
>  
>  # Compiler for building kexec
>  CC		= @CC@
> diff --git a/include/byteswap.h b/include/byteswap.h
> new file mode 100644
> index 0000000..cd5a726
> --- /dev/null
> +++ b/include/byteswap.h
> @@ -0,0 +1,39 @@
> +/* byteswap.h
> +
> +Copyright 2005 Red Hat, Inc.
> +
> +This file is part of Cygwin.
> +
> +This software is a copyrighted work licensed under the terms of the
> +Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
> +details. */
> +
> +#ifndef _BYTESWAP_H
> +#define _BYTESWAP_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +static __inline unsigned short
> +bswap_16 (unsigned short __x)
> +{
> +  return (__x >> 8) | (__x << 8);
> +}
> +
> +static __inline unsigned int
> +bswap_32 (unsigned int __x)
> +{
> +  return (bswap_16 (__x & 0xffff) << 16) | (bswap_16 (__x >> 16));
> +}
> +
> +static __inline unsigned long long
> +bswap_64 (unsigned long long __x)
> +{
> +  return (((unsigned long long) bswap_32 (__x & 0xffffffffull)) << 32) | (bswap_32 (__x >> 32));
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +#endif /* _BYTESWAP_H */
> diff --git a/kexec/Makefile b/kexec/Makefile
> index a80b940..fe05340 100644
> --- a/kexec/Makefile
> +++ b/kexec/Makefile
> @@ -11,16 +11,22 @@ KEXEC_SRCS =
>  KEXEC_GENERATED_SRCS =
>  
>  KEXEC_SRCS += kexec/kexec.c
> +ifneq ($(host_os),mingw32msvc)
>  KEXEC_SRCS += kexec/ifdown.c
> +endif
>  KEXEC_SRCS += kexec/kexec-elf.c
>  KEXEC_SRCS += kexec/kexec-elf-exec.c
>  KEXEC_SRCS += kexec/kexec-elf-core.c
>  KEXEC_SRCS += kexec/kexec-elf-rel.c
>  KEXEC_SRCS += kexec/kexec-elf-boot.c
>  KEXEC_SRCS += kexec/kexec-iomem.c
> +ifneq ($(host_os),mingw32msvc)
>  KEXEC_SRCS += kexec/crashdump.c
>  KEXEC_SRCS += kexec/crashdump-xen.c
>  KEXEC_SRCS += kexec/phys_arch.c
> +else
> +KEXEC_SRCS += kexec/win32.c
> +endif
>  
>  KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
>  
> diff --git a/kexec/arch/i386/Makefile b/kexec/arch/i386/Makefile
> index f2d9636..f9dbb7b 100644
> --- a/kexec/arch/i386/Makefile
> +++ b/kexec/arch/i386/Makefile
> @@ -9,7 +9,9 @@ i386_KEXEC_SRCS += kexec/arch/i386/kexec-multiboot-x86.c
>  i386_KEXEC_SRCS += kexec/arch/i386/kexec-beoboot-x86.c
>  i386_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
>  i386_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
> +ifneq ($(host_os),mingw32msvc)
>  i386_KEXEC_SRCS += kexec/arch/i386/crashdump-x86.c
> +endif
>  
>  dist += kexec/arch/i386/Makefile $(i386_KEXEC_SRCS)			\
>  	kexec/arch/i386/kexec-x86.h kexec/arch/i386/crashdump-x86.h	\
> diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
> index 89ccb0b..f937856 100644
> --- a/kexec/arch/i386/kexec-x86.c
> +++ b/kexec/arch/i386/kexec-x86.c
> @@ -32,6 +32,7 @@
>  #include "crashdump-x86.h"
>  #include <arch/options.h>
>  
> +#ifndef __MINGW32__
>  static struct memory_range memory_range[MAX_MEMORY_RANGES];
>  
>  /* Return a sorted list of memory ranges. */
> @@ -113,6 +114,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>  	*ranges = memory_ranges;
>  	return 0;
>  }
> +#endif /* !defined(__MINGW32__) */
>  
>  struct file_type file_type[] = {
>  	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load, 
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 4b9a5e5..e750d82 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -23,8 +23,10 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
> +#ifndef __MINGW32__
>  #include <sys/ioctl.h>
>  #include <linux/fb.h>
> +#endif
>  #include <unistd.h>
>  #include <x86/x86-linux.h>
>  #include "../../kexec.h"
> @@ -101,6 +103,7 @@ void setup_linux_bootloader_parameters(
>  
>  int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
>  {
> +#ifndef __MINGW32__
>  	struct fb_fix_screeninfo fix;
>  	struct fb_var_screeninfo var;
>  	int fd;
> @@ -153,6 +156,7 @@ int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
>  
>   out:
>  	close(fd);
> +#endif /* !defined(__MINGW32__) */
>  	return -1;
>  }
>  
> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> index 2b9345f..f6f8dc5 100644
> --- a/kexec/kexec-syscall.h
> +++ b/kexec/kexec-syscall.h
> @@ -1,6 +1,8 @@
>  #ifndef KEXEC_SYSCALL_H
>  #define KEXEC_SYSCALL_H
>  
> +#ifndef __MINGW32__
> +
>  #define __LIBRARY__
>  #include <syscall.h>
>  #include <sys/syscall.h>
> @@ -69,6 +71,11 @@ static inline long kexec_reboot(void)
>  	return (long) syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC, 0);
>  }
>  
> +#else /* defined(__MINGW32__) */
> +extern long kexec_load(void *entry, unsigned long nr_segments,
> +		       struct kexec_segment *segments, unsigned long flags);
> +extern long kexec_reboot(void);
> +#endif /* defined(__MINGW32__) */
>  
>  #define KEXEC_ON_CRASH  0x00000001
>  #define KEXEC_ARCH_MASK 0xffff0000
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 0b02a3a..27a3573 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -804,6 +804,7 @@ static int kexec_loaded(void)
>  /* check we retained the initrd */
>  void check_reuse_initrd(void)
>  {
> +#ifndef __MINGW32__
>  	FILE * fp;
>  	char * line = NULL;
>  	size_t len = 0;
> @@ -814,11 +815,14 @@ void check_reuse_initrd(void)
>  		die("unable to open /proc/cmdline\n");
>  	read = getline(&line, &len, fp);
>  	if (strstr(line, "retain_initrd") == NULL)
> +#endif
>  		die("unrecoverable error: current boot didn't "
>  		    "retain the initrd for reuse.\n");
> +#ifndef __MINGW32__
>  	if (line)
>  		free(line);
>  	fclose(fp);
> +#endif
>  }
>  
>  int main(int argc, char *argv[])
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 3724862..f7a64ac 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -8,7 +8,13 @@
>  #include <stdint.h>
>  #define USE_BSD
>  #include <byteswap.h>
> +#ifdef __MINGW32__
> +#include <sys/param.h>
> +extern int getpagesize(void);
> +#define sync()
> +#else
>  #include <endian.h>
> +#endif
>  #define _GNU_SOURCE
>  
>  #include "kexec-elf.h"
> @@ -217,7 +223,11 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
>  	int buf_end, int phys);
>  extern void arch_reuse_initrd(void);
>  
> +#ifdef __MINGW32__
> +#define ifdown()
> +#else
>  extern int ifdown(void);
> +#endif
>  
>  extern unsigned char purgatory[];
>  extern size_t purgatory_size;
> diff --git a/kexec/win32.c b/kexec/win32.c
> new file mode 100644
> index 0000000..d3c18db
> --- /dev/null
> +++ b/kexec/win32.c
> @@ -0,0 +1,214 @@
> +#include "kexec.h"
> +#include "kexec-syscall.h"
> +#include <errno.h>
> +#include <stddef.h>
> +#define _WIN32_WINNT 0x0501
> +#include <windows.h>
> +#include <ddk/ntddk.h>
> +
> +#define IOCTL_LOAD_KERNEL CTL_CODE(FILE_DEVICE_UNKNOWN, 0x800, METHOD_BUFFERED, FILE_ANY_ACCESS)
> +
> +struct kexec_user_segment {
> +	size_t bufsz;
> +	unsigned long mem;
> +	size_t memsz;
> +};
> +
> +struct kexec_user_buffer {
> +	unsigned long entry;
> +	unsigned long kexec_flags;
> +	int nr_segments;
> +	struct kexec_user_segment segments[0];
> +};
> +
> +int getpagesize(void)
> +{
> +	SYSTEM_INFO sysinfo;
> +	GetNativeSystemInfo(&sysinfo);
> +	return sysinfo.dwPageSize;
> +}
> +
> +long physical_arch(void)
> +{
> +	SYSTEM_INFO sysinfo;
> +	GetNativeSystemInfo(&sysinfo);
> +	switch(sysinfo.wProcessorArchitecture) {
> +	case PROCESSOR_ARCHITECTURE_INTEL:
> +		/* For compatibility with older patches
> +		 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_386 here.
> +		 */
> +		return KEXEC_ARCH_DEFAULT;
> +
> +	case PROCESSOR_ARCHITECTURE_AMD64:
> +		return KEXEC_ARCH_X86_64;
> +	}
> +	fprintf(stderr, "Unsupported machine type: %d\n",
> +		sysinfo.wProcessorArchitecture);
> +	return -1;
> +}
> +
> +int get_memory_ranges(struct memory_range **range, int *ranges,
> +				unsigned long kexec_flags)
> +{
> +	static struct memory_range *memory_range;
> +	static int memory_ranges;
> +
> +	HKEY key = HKEY_LOCAL_MACHINE;
> +	char path[] = "HARDWARE\\RESOURCEMAP\\System Resources\\Physical Memory\\.Translated";
> +	char *next = path;
> +	char *slash;
> +	LONG result;
> +	DWORD size, type;
> +	void *buf = 0;
> +	CM_RESOURCE_LIST *resource_list;
> +	CM_PARTIAL_RESOURCE_LIST *partial_list;
> +	int i;
> +
> +	if(memory_range)
> +	{
> +		*range = memory_range;
> +		*ranges = memory_ranges;
> +		return 0;
> +	}
> +
> +	while((slash = strchr(next, '\\')))
> +	{
> +		HKEY subkey;
> +		*slash = '\0';
> +		result = RegOpenKeyEx(key, next, 0, KEY_READ, &subkey);
> +		RegCloseKey(key);
> +		if(result != ERROR_SUCCESS)
> +		{
> +			fprintf(stderr, "get_memory_ranges: registry key '%s' not found\n", next);
> +			return -1;
> +		}
> +		key = subkey;
> +		next = slash + 1;
> +	}
> +
> +	if((result = RegQueryValueEx(key, next, 0, 0, 0, &size)) == ERROR_SUCCESS)
> +	{
> +		buf = malloc(size);
> +		if(!buf)
> +		{
> +			RegCloseKey(key);
> +			fprintf(stderr, "get_memory_ranges: %s\n", strerror(errno));
> +			return -1;
> +		}
> +		result = RegQueryValueEx(key, next, 0, &type, buf, &size);
> +	}
> +	RegCloseKey(key);
> +	if(result != ERROR_SUCCESS)
> +	{
> +		fprintf(stderr, "get_memory_ranges: registry key '%s' not found\n", next);
> +		goto fail;
> +	}
> +	if(type != REG_RESOURCE_LIST)
> +	{
> +		fprintf(stderr, "get_memory_ranges: registry key '%s' has wrong type\n", next);
> +		goto fail;
> +	}
> +	resource_list = buf;
> +	partial_list = &resource_list->List[0].PartialResourceList;
> +	if(size < offsetof(CM_RESOURCE_LIST, List[0].PartialResourceList.PartialDescriptors) ||
> +	   resource_list->Count != 1 ||
> +	   size < (char *) (partial_list->PartialDescriptors + partial_list->Count) - (char *) buf)
> +	{
> +		fprintf(stderr, "get_memory_ranges: registry key '%s' is too small\n", next);
> +		goto fail;
> +	}
> +
> +	memory_ranges = partial_list->Count;
> +	memory_range = malloc(sizeof(*memory_range) * memory_ranges);
> +	if(!memory_range)
> +	{
> +		fprintf(stderr, "get_memory_ranges: %s\n", strerror(errno));
> +		goto fail;
> +	}
> +	for(i = 0; i < memory_ranges; ++i)
> +	{
> +		if(partial_list->PartialDescriptors[i].Type != CmResourceTypeMemory)
> +		{
> +			free(memory_range);
> +			memory_range = 0;
> +			fprintf(stderr, "get_memory_ranges: range %d is not memory\n", i + 1);
> +			goto fail;
> +		}
> +		memory_range[i].start = partial_list->PartialDescriptors[i].u.Memory.Start.QuadPart;
> +		memory_range[i].end = memory_range[i].start + partial_list->PartialDescriptors[i].u.Memory.Length;
> +		memory_range[i].type = RANGE_RAM;
> +	}
> +
> +	*range = memory_range;
> +	*ranges = memory_ranges;
> +	return 0;
> +
> +fail:
> +	free(buf);
> +	return -1;
> +}
> +
> +long kexec_load(void *entry, unsigned long nr_segments,
> +		struct kexec_segment *segments, unsigned long flags)
> +{
> +	struct kexec_user_buffer *image;
> +	long size = sizeof(*image) + nr_segments * sizeof(*image->segments);
> +	DWORD bytes_returned;
> +	char *tmp;
> +	int i, success;
> +
> +	for(i = 0; i < nr_segments; ++i)
> +		size += segments[i].bufsz;
> +
> +	image = malloc(size);
> +	if(!image)
> +		return -1;
> +
> +	image->entry = (unsigned long) entry;
> +	image->kexec_flags = flags;
> +	image->nr_segments = nr_segments;
> +	tmp = (char *) (image->segments + nr_segments);
> +	for(i = 0; i < nr_segments; ++i)
> +	{
> +		image->segments[i].bufsz = segments[i].bufsz;
> +		image->segments[i].mem = (unsigned long) segments[i].mem;
> +		image->segments[i].memsz = segments[i].memsz;
> +		memcpy(tmp, segments[i].buf, segments[i].bufsz);
> +		tmp += segments[i].bufsz;
> +	}
> +
> +	HANDLE device = CreateFile(TEXT("\\\\.\\kexec"),
> +			/* open mode */ 0,
> +			FILE_SHARE_READ | FILE_SHARE_WRITE,
> +			/* security attributes */ NULL,
> +			OPEN_EXISTING,
> +			/* file attributes */ 0,
> +			/* template file */ NULL);
> +
> +	success = device != INVALID_HANDLE_VALUE && DeviceIoControl(device,
> +				IOCTL_LOAD_KERNEL,
> +				image, size,
> +				NULL, 0, &bytes_returned,
> +				/* async structure */ (LPOVERLAPPED) NULL);
> +
> +	CloseHandle(device);
> +	free(image);
> +	return success ? 0 : -1;
> +}
> +
> +long kexec_reboot(void)
> +{
> +	errno = ENOSYS;
> +	return -1;
> +}
> +
> +int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> +			    unsigned long max_addr, unsigned long min_base)
> +{
> +	return -1;
> +}
> +
> +int is_crashkernel_mem_reserved(void)
> +{
> +	return 0;
> +}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
